# define your working directory path here

using Pkg
Pkg.add("DataFrames")
Pkg.add("GLM")
using DataFrames, LinearAlgebra, Statistics, GLM
data = DataFrame(Array{Union{Missing,Float64}}(randn(1000,202)))
data[1:end,202]=1
headers = [ :y ; [ Symbol("x$i") for i = 1:size(data,2) - 1 ] ]
names!(data, headers)

cols = [:x1,:x2,:x3,:x4,:x5,:x6,:x7,:x8,:x9,:x10,:x11,:x12,:x13,:x14,:x15,:x16,:x17,:x18,:x19,:x20,:x21,:x22,:x23,:x24,:x25,:x26,:x27,:x28,:x29,:x30,:x31,:x32,:x33,:x34,:x35,:x36,:x37,:x38,:x39,:x40,:x41,:x42,:x43,:x44,:x45,:x46,:x47,:x48,:x49,:x50,:x51,:x52,:x53,:x54,:x55,:x56,:x57,:x58,:x59,:x60,:x61,:x62,:x63,:x64,:x65,:x66,:x67,:x68,:x69,:x70,:x71,:x72,:x73,:x74,:x75,:x76,:x77,:x78,:x79,:x80,:x81,:x82,:x83,:x84,:x85,:x86,:x87,:x88,:x89,:x90,:x91,:x92,:x93,:x94,:x95,:x96,:x97,:x98,:x99,:x100,:x101,:x102,:x103,:x104,:x105,:x106,:x107,:x108,:x109,:x110,:x111,:x112,:x113,:x114,:x115,:x116,:x117,:x118,:x119,:x120,:x121,:x122,:x123,:x124,:x125,:x126,:x127,:x128,:x129,:x130,:x131,:x132,:x133,:x134,:x135,:x136,:x137,:x138,:x139,:x140,:x141,:x142,:x143,:x144,:x145,:x146,:x147,:x148,:x149,:x150,:x151,:x152,:x153,:x154,:x155,:x156,:x157,:x158,:x159,:x160,:x161,:x162,:x163,:x164,:x165,:x166,:x167,:x168,:x169,:x170,:x171,:x172,:x173,:x174,:x175,:x176,:x177,:x178,:x179,:x180,:x181,:x182,:x183,:x184,:x185,:x186,:x187,:x188,:x189,:x190,:x191,:x192,:x193,:x194,:x195,:x196,:x197,:x198,:x199,:x200,:x201]
depvar_data = convert(Array{Float64},@view(data[1:end, 1]))
expvars_data = convert(Array{Float64}, @view(data[1:end, cols]))
nobs = size(depvar_data, 1)
ncoef = size(expvars_data, 2)

include("qrreg2.jl")

#1
b=@elapsed qrreg(data)

#2 with new dataset (operation were chached)
data2 = DataFrame(Array{Union{Missing,Float64}}(randn(1000,202)))
data2[1:end,202]=1
headers = [ :y ; [ Symbol("x$i") for i = 1:size(data2,2) - 1 ] ]
names!(data2, headers)

b=@elapsed qrreg(data2)

#3
data3 = DataFrame(Array{Union{Missing,Float64}}(randn(1000,202)))
data3[1:end,202]=1
headers = [ :y ; [ Symbol("x$i") for i = 1:size(data3,2) - 1 ] ]
names!(data3, headers)

b=@elapsed qrreg(data3)

#4
data4 = DataFrame(Array{Union{Missing,Float64}}(randn(1000,202)))
data4[1:end,202]=1
headers = [ :y ; [ Symbol("x$i") for i = 1:size(data4,2) - 1 ] ]
names!(data4, headers)

b=@elapsed qrreg(data4)

#5
data5 = DataFrame(Array{Union{Missing,Float64}}(randn(1000,202)))
data5[1:end,202]=1
headers = [ :y ; [ Symbol("x$i") for i = 1:size(data5,2) - 1 ] ]
names!(data5, headers)

b=@elapsed qrreg(data5)


################################################################
#GML regression

#1
data5 = DataFrame(Array{Union{Missing,Float64}}(randn(1000,202)))
data5[1:end,202]=1
headers = [ :y ; [ Symbol("x$i") for i = 1:size(data5,2) - 1 ] ]
names!(data5, headers)

@elapsed ols = lm(@formula(y ~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14+
x15+x16+x17+x18+x19+x20+x21+x22+x23+x24+x25+x26+x27+x28+x29+x30+x31+x32+x33+x34
+x35+x36+x37+x38+x39+x40+x41+x42+x43+x44+x45+x46+x47+x48+x49+x50+x51+x52+x53+
x54+x55+x56+x57+x58+x59+x60+x61+x62+x63+x64+x65+x66+x67+x68+x69+x70+x71+x72+x73
+x74+x75+x76+x77+x78+x79+x80+x81+x82+x83+x84+x85+x86+x87+x88+x89+x90+x91+x92+x93
+x94+x95+x96+x97+x98+x99+x100+x101+x102+x103+x104+x105+x106+x107+x108+x109+x110
+x111+x112+x113+x114+x115+x116+x117+x118+x119+x120+x121+x122+x123+x124+x125+x126
+x127+x128+x129+x130+x131+x132+x133+x134+x135+x136+x137+x138+x139+x140+x141+x142
+x143+x144+x145+x146+x147+x148+x149+x150+x151+x152+x153+x154+x155+x156+x157+x158
+x159+x160+x161+x162+x163+x164+x165+x166+x167+x168+x169+x170+x171+x172+x173+x174
+x175+x176+x177+x178+x179+x180+x181+x182+x183+x184+x185+x186+x187+x188+x189+x190
+x191+x192+x193+x194+x195+x196+x197+x198+x199+x200), data5)

#2 with new dataset (operation were chached)
data5 = DataFrame(Array{Union{Missing,Float64}}(randn(1000,202)))
data5[1:end,202]=1
headers = [ :y ; [ Symbol("x$i") for i = 1:size(data5,2) - 1 ] ]
names!(data5, headers)

@elapsed ols = lm(@formula(y ~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14+
x15+x16+x17+x18+x19+x20+x21+x22+x23+x24+x25+x26+x27+x28+x29+x30+x31+x32+x33+x34
+x35+x36+x37+x38+x39+x40+x41+x42+x43+x44+x45+x46+x47+x48+x49+x50+x51+x52+x53+
x54+x55+x56+x57+x58+x59+x60+x61+x62+x63+x64+x65+x66+x67+x68+x69+x70+x71+x72+x73
+x74+x75+x76+x77+x78+x79+x80+x81+x82+x83+x84+x85+x86+x87+x88+x89+x90+x91+x92+x93
+x94+x95+x96+x97+x98+x99+x100+x101+x102+x103+x104+x105+x106+x107+x108+x109+x110
+x111+x112+x113+x114+x115+x116+x117+x118+x119+x120+x121+x122+x123+x124+x125+x126
+x127+x128+x129+x130+x131+x132+x133+x134+x135+x136+x137+x138+x139+x140+x141+x142
+x143+x144+x145+x146+x147+x148+x149+x150+x151+x152+x153+x154+x155+x156+x157+x158
+x159+x160+x161+x162+x163+x164+x165+x166+x167+x168+x169+x170+x171+x172+x173+x174
+x175+x176+x177+x178+x179+x180+x181+x182+x183+x184+x185+x186+x187+x188+x189+x190
+x191+x192+x193+x194+x195+x196+x197+x198+x199+x200), data5)

#3
data5 = DataFrame(Array{Union{Missing,Float64}}(randn(1000,202)))
data5[1:end,202]=1
headers = [ :y ; [ Symbol("x$i") for i = 1:size(data5,2) - 1 ] ]
names!(data5, headers)

@elapsed ols = lm(@formula(y ~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14+
x15+x16+x17+x18+x19+x20+x21+x22+x23+x24+x25+x26+x27+x28+x29+x30+x31+x32+x33+x34
+x35+x36+x37+x38+x39+x40+x41+x42+x43+x44+x45+x46+x47+x48+x49+x50+x51+x52+x53+
x54+x55+x56+x57+x58+x59+x60+x61+x62+x63+x64+x65+x66+x67+x68+x69+x70+x71+x72+x73
+x74+x75+x76+x77+x78+x79+x80+x81+x82+x83+x84+x85+x86+x87+x88+x89+x90+x91+x92+x93
+x94+x95+x96+x97+x98+x99+x100+x101+x102+x103+x104+x105+x106+x107+x108+x109+x110
+x111+x112+x113+x114+x115+x116+x117+x118+x119+x120+x121+x122+x123+x124+x125+x126
+x127+x128+x129+x130+x131+x132+x133+x134+x135+x136+x137+x138+x139+x140+x141+x142
+x143+x144+x145+x146+x147+x148+x149+x150+x151+x152+x153+x154+x155+x156+x157+x158
+x159+x160+x161+x162+x163+x164+x165+x166+x167+x168+x169+x170+x171+x172+x173+x174
+x175+x176+x177+x178+x179+x180+x181+x182+x183+x184+x185+x186+x187+x188+x189+x190
+x191+x192+x193+x194+x195+x196+x197+x198+x199+x200), data5)

#4
data5 = DataFrame(Array{Union{Missing,Float64}}(randn(1000,202)))
data5[1:end,202]=1
headers = [ :y ; [ Symbol("x$i") for i = 1:size(data5,2) - 1 ] ]
names!(data5, headers)

@elapsed ols = lm(@formula(y ~x1+x2+x3+x4+x5+x6+x7+x8+x9+x10+x11+x12+x13+x14+
x15+x16+x17+x18+x19+x20+x21+x22+x23+x24+x25+x26+x27+x28+x29+x30+x31+x32+x33+x34
+x35+x36+x37+x38+x39+x40+x41+x42+x43+x44+x45+x46+x47+x48+x49+x50+x51+x52+x53+
x54+x55+x56+x57+x58+x59+x60+x61+x62+x63+x64+x65+x66+x67+x68+x69+x70+x71+x72+x73
+x74+x75+x76+x77+x78+x79+x80+x81+x82+x83+x84+x85+x86+x87+x88+x89+x90+x91+x92+x93
+x94+x95+x96+x97+x98+x99+x100+x101+x102+x103+x104+x105+x106+x107+x108+x109+x110
+x111+x112+x113+x114+x115+x116+x117+x118+x119+x120+x121+x122+x123+x124+x125+x126
+x127+x128+x129+x130+x131+x132+x133+x134+x135+x136+x137+x138+x139+x140+x141+x142
+x143+x144+x145+x146+x147+x148+x149+x150+x151+x152+x153+x154+x155+x156+x157+x158
+x159+x160+x161+x162+x163+x164+x165+x166+x167+x168+x169+x170+x171+x172+x173+x174
+x175+x176+x177+x178+x179+x180+x181+x182+x183+x184+x185+x186+x187+x188+x189+x190
+x191+x192+x193+x194+x195+x196+x197+x198+x199+x200), data5)

