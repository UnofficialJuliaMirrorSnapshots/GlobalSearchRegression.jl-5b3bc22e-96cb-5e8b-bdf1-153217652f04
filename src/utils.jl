"""
Returns if a vector is inside another vector
"""
function in_vector(sub_vector, vector)
    for sv in sub_vector
        if !in(sv, vector)
            return false
        end
    end
    return true
end

"""
Gets array column index by a name
"""
function get_column_index(name, names)
    return findfirst(isequal(name), names)
end

# OLD

"""
Returns the position of the header value based on this structure.
    - Index
    - Covariates
        * b
        * bstd
        * T-test
    - Equation general information merged with criteria user-defined options.
    - Order from user combined criteria
    - Weight
"""
function get_data_position(name, expvars, intercept, ttest, residualtest, time, criteria)
    data_cols_num = length(expvars)
    mult_col = (ttest == true) ? 3 : 1

    # INDEX
    if name == INDEX
        return 1
    end
    displacement = 1
    displacement += mult_col * (data_cols_num) + 1

    # EQUATION_GENERAL_INFORMATION
    testfields = (residualtest != nothing && residualtest) ? ((time != nothing) ? RESIDUAL_TESTS_TIME : RESIDUAL_TESTS_CROSS) : []
    equation_general_information_and_criteria = unique([ EQUATION_GENERAL_INFORMATION; criteria; testfields ])
    if name in equation_general_information_and_criteria
        return displacement + findfirst(isequal(name), equation_general_information_and_criteria) - 1
    end
    displacement += length(equation_general_information_and_criteria)

    if name == ORDER
        return displacement
    end
    displacement += 1

    if name == WEIGHT
        return displacement
    end
    displacement = 1

    # Covariates
    string_name = string(name)
    base_name = Symbol(replace(replace(replace(string_name, "_bstd" => ""), "_t" => ""), "_b" => ""))
    if base_name in expvars
        displacement = displacement + (findfirst(isequal(base_name), expvars) - 1) * mult_col
        if occursin("_bstd", string_name)
            return displacement + 2
        end
        if occursin("_b", string_name)
            return displacement + 1
        end
        if occursin("_t", string_name)
            return displacement + 3
        end
    end
end

"""
Constructs the header for results based in get_data_position orders.
"""
function get_result_header(expvars, intercept, ttest, residualtest, time, criteria, modelavg)
    header = Dict{Symbol,Int64}()
    header[:index] = get_data_position(:index, expvars, intercept, ttest, residualtest, time, criteria)
    for expvar in expvars
        header[Symbol(string(expvar,"_b"))] = get_data_position(Symbol(string(expvar,"_b")), expvars, intercept, ttest, residualtest, time, criteria)
        if ttest
            header[Symbol(string(expvar,"_bstd"))] = get_data_position(Symbol(string(expvar,"_bstd")), expvars, intercept, ttest, residualtest, time, criteria)
            header[Symbol(string(expvar,"_t"))] = get_data_position(Symbol(string(expvar,"_t")), expvars, intercept, ttest, residualtest, time, criteria)
        end
    end

    keys = unique([ EQUATION_GENERAL_INFORMATION; criteria ])

    if residualtest != nothing && residualtest
        keys = unique([ keys; (time != nothing) ? RESIDUAL_TESTS_TIME : RESIDUAL_TESTS_CROSS ])
    end

    for key in keys
        header[key] = get_data_position(key, expvars, intercept, ttest, residualtest, time, criteria)
    end

    header[:order] = get_data_position(:order, expvars, intercept, ttest, residualtest, time, criteria)
    if modelavg
        header[:weight] = get_data_position(:weight, expvars, intercept, ttest, residualtest, time, criteria)
    end
    return header
end

"""
Returns selected appropiate covariates for each iteration
"""
function get_selected_cols(i)
    cols = zeros(Int64, 0)
    binary = string(i, base = 2)
    k = 2
    for i = 1:length(binary)
        if binary[length(binary) - i + 1] == '1'
            append!(cols, k)
        end
        k = k + 1
    end
    return cols
end

function gsregsortrows(B::AbstractMatrix,cols::Array; kws...)
    for i = 1:length(cols)
        if i == 1
            p = sortperm(B[:,cols[i]]; kws...)
            B = B[p,:]
        else
            i0_old = 0
            i1_old = 0
            i0_new = 0
            i1_new = 0
            for j = 1:size(B,1)-1
                if B[j,cols[1:i-1]] == B[j+1,cols[1:i-1]] && i0_old == i0_new
                    i0_new = j
                elseif B[j,cols[1:i-1]] != B[j+1,cols[1:i-1]] && i0_old != i0_new && i1_new == i1_old
                    i1_new = j
                elseif i0_old != i0_new && j == size(B,1)-1
                    i1_new = j+1
                end
                if i0_new != i0_old && i1_new != i1_old
                    p = sortperm(B[i0_new:i1_new,cols[i]]; kws...)
                    B[i0_new:i1_new,:] = B[i0_new:i1_new,:][p,:]
                    i0_old = i0_new
                    i1_old = i1_new
                end
            end
        end
    end
    return B
end

function export_csv(io::IO, result::GSRegResult)
    head = []
    for elem in sort(collect(Dict(value => key for (key, value) in result.header)))
         push!(head, elem[2])
    end
    writedlm(io, [head], ',')
    writedlm(io, result.results, ',')
end

"""
Exports main results with headers to file
"""
function export_csv(output::String, result::GSRegResult)
    file = open(output, "w")
    export_csv(file, result)
    close(file)
end

function get_data_column_pos(name, datanames)
    return findfirst(x -> name==x, datanames)
end
