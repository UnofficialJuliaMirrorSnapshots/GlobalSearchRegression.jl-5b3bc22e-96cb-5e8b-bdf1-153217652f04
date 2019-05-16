"""
Converts and returns an array of string to an array of Symbol
"""
function strarr_to_symarr!(arr)
    return arr = [ Symbol(str) for str in arr ]
end

"""
Converts and returns an equation string to an array of variables as string 
"""
function equation_str_to_strarr!(equation)
    if occursin("~", equation)
        vars = split(replace(equation, r"\s+|\s+$/g" => " "), "~")
        equation = [String(strip(var)) for var in vcat(vars[1], split(vars[2], "+"))]
    else
        equation = [String(strip(var)) for var in split(replace(equation, r"\s+|\s+$/g" => ","), ",")]
    end
    equation = filter(x->length(x) > 0, equation)    
    return equation
end

"""
Converts and returns a strarr equation with wildcards to a strarr with wildcards processed
"""
function equation_converts_wildcards!(equation, names)
    new_equation = []
    for e in equation
        e = replace(e, "." => "*")
        if e[end] == '*'
            datanames_arr = vec([String(key)[1:length(e[1:end - 1])] == e[1:end - 1] ? String(key) : nothing for key in names])
            append!(new_equation, filter!(x->x != nothing, datanames_arr))
        else
            append!(new_equation, [e])
        end
    end
    equation = unique(new_equation)
    return equation
end

"""
Gets datanames from data DataFrame or data Tuple
"""
function get_datanames_from_data(data, datanames)
    if isa(data, DataFrames.DataFrame)
        datanames = names(data)
    elseif isa(data, Tuple)
        datanames = data[2]
        if !isa(datanames, Vector)
            datanames = vec(datanames)
        end
    end
    return strarr_to_symarr!(datanames)
end

"""
Gets datanames from data DataFrame or data Tuple
"""
function get_data_from_data(data)
    if isa(data, DataFrames.DataFrame)
        data = convert(Array{Union{Missing, Float64}}, data)
    elseif isa(data, Tuple)
        data = data[1]
    end
    return data
end

"""
Sorts data
"""
function sort_data(data, datanames; time=nothing, panel=nothing)
    time_pos = get_column_index(time, datanames)
    panel_pos = get_column_index(panel, datanames)

    if time_pos != nothing && panel_pos != nothing
        data = sortslices(data, by=x->(x[panel_pos], x[time_pos]), dims=1)
    elseif panel_pos != nothing
        data = sortslices(data, by=x->(x[panel_pos]), dims=1)
    elseif time_pos != nothing
        data = sortslices(data, by=x->(x[time_pos]), dims=1)
    end
    return data
end

"""
Filter data by selected columns
"""
function filter_data_by_selected_columns(data, equation, datanames)
    columns = []
    for i = 1:length(equation)
        append!(columns, get_column_index(equation[i], datanames))
    end
    data = data[:,columns]
    datanames = datanames[columns]
    
    return (data, datanames)
end

"""
Filter data by empty values
"""
function filter_data_by_empty_values(data)
    for i = 1:size(data, 2)
        data = data[map(b->!b, ismissing.(data[:,i])), :]
    end
    return data
end

"""
Validates if there are time gaps
"""
function validate_time(data, datanames; panel=nothing, time=nothing)
    nobs = size(data, 1)

    # TODO: Merge solutions
    if panel == nothing
        previous_value = data[1, get_column_index(time, datanames)]
        for value in data[2:end, get_column_index(time, datanames)]
            if previous_value + 1 != value
                return false
            end
            previous_value = value
        end
    else
        panel_index = get_column_index(panel, datanames)
        csis = unique(data[:, panel_index])
        time_index = get_column_index(time, datanames)
        for csi in csis
            rows = findall(x->x == csi, data[:,panel_index])
            previous_value = data[rows[1], time_index]
            for row in rows[2:end]
                value = data[row, time_index]
                if previous_value + 1 != value
                    return false
                end
                previous_value = value
            end
        end
    end
    return true
end