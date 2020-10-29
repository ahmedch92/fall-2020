cd("D:\\Semester 3_Fall 2020\\ECON 6453 - Econometrics III\\ProblemSets\\PS8-factor")
using Random, Distributions, JLD2, DataFrames, CSV, LinearAlgebra, Statistics, FreqTables, TexTables, Optim, HTTP, GLM, ForwardDiff, DataFramesMeta, MultivariateStats

function problemset8()

#:::::::::::::::::::::::::::::::::::::::::::::::::::
# Question 1
#:::::::::::::::::::::::::::::::::::::::::::::::::::
url = "https://raw.githubusercontent.com/OU-PhD-Econometrics/fall-2020/master/ProblemSets/PS8-factor/nlsy.csv"
df = CSV.read(HTTP.get(url).body)

ols = glm(@formula(logwage ~ black + hispanic + female + schoolt + gradHS + grad4yr), df, Normal())
print(ols)

#:::::::::::::::::::::::::::::::::::::::::::::::::::
# Question 2
#:::::::::::::::::::::::::::::::::::::::::::::::::::
asvabMat=convert(Matrix,df[:,r"asvab"])
corr_asvab=cor(asvabMat)
print(corr_asvab)

#:::::::::::::::::::::::::::::::::::::::::::::::::::
# Question 3
#:::::::::::::::::::::::::::::::::::::::::::::::::::
ols2 = glm(@formula(logwage ~ black + hispanic + female + schoolt + gradHS + grad4yr + asvabAR + asvabCS + asvabMK + asvabNO + asvabPC + asvabWK), df, Normal())
print(ols2)

# The coefficient on the variable schoolt turns negative by inserting asvab variables.
# So, this specification is clearly wrong since increase in 'school time' should increase the wages.
# So there must be a specification bias in this model.

#:::::::::::::::::::::::::::::::::::::::::::::::::::
# Question 4
#:::::::::::::::::::::::::::::::::::::::::::::::::::
M = fit(PCA, asvabMat'; maxoutdim=1)
asvab_principalcomp = MultivariateStats.transform(M, asvabMat')

#:::::::::::::::::::::::::::::::::::::::::::::::::::
# Question 5
#:::::::::::::::::::::::::::::::::::::::::::::::::::
M = fit(FactorAnalysis, asvabMat'; maxoutdim=1)
asvab_factor = MultivariateStats.transform(M, asvabMat')

#:::::::::::::::::::::::::::::::::::::::::::::::::::
# Question 6
#:::::::::::::::::::::::::::::::::::::::::::::::::::

#This is the part where I cannot figure out how to code exactly.
#I think we will start be defining vectors then followed by maximum likelihood/loglikelihood function.

end
problemset8()
