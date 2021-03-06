# indicators.R - DESC
# /indicators.R

# Copyright European Union, 2018
# Author: Iago Mosqueira (EC JRC) <iago.mosqueira@ec.europa.eu>
#
# Distributed under the terms of the European Union Public Licence (EUPL) V.1.1.

indicators <- list(
  # SB0
  SB0 = list(~yearMeans(SB/SB0), name = "SB/SB[0]",
    desc = "Mean spawner biomass relative to unfished"),
  # SBMSY
  SBMSY = list(~yearMeans(SB/SBMSY), name = "SB/SB[MSY]",
    desc = "Mean spawnwer biomass relative to SBMSY"),
  # Ftarget
  Ftarget = list(~yearMeans(F/Ftarget), name = "F/F[target]",
    desc = "Mean fishing mortality relative to target"),
  # FMSY
  FMSY = list(~yearMeans(F/FMSY), name = "F/F[MSY]",
    desc = "Mean fishing mortality relative to FMSY"),
  # green
  green = list(~yearSums(FLQuant((SB / SBMSY) > 1 & (F / FMSY) < 1)) / dim(SB)[2],
    name = "P(Green)", desc = "Probability of being in Kobe green quadrant"),
  # red
  red = list(~yearSums(FLQuant((SB / SBMSY) < 1 & (F / FMSY) > 1)) / dim(SB)[2],
    name = "P(Red)", desc = "Probability of being in Kobe red quadrant"),
  # PSBMSY
  PSBMSY = list(~yearMeans((SB / SBMSY) >= 1),
    name = "P(SB>=SB[MSY])",  desc = "Probability of SB greater or equal to SBMSY"),
  # PBlim
  PBlim = list(~yearSums((SB / SBlim) > 1) / dim(SB)[2], name = "P(SB>B[limit])", 
    desc = "Probability that spawner biomass is above Blim"),
  # C
  C = list(~yearMeans(C), name = "mean(C)", desc = "Mean catch over years"),
  # VarC
  VarC = list(~rescale(sqrt(yearVars(C)) / yearMeans(C)), name = "Var(Catch)",
    desc = "Catch variability"),
  # PC0
  PC0 = list(~yearSums(C < 0.1 * MSY) / dim(C)[2], name = "P(shutdown)", 
    desc = "Probability of fishery shutdown")
  )

kobeindicators <- list(
  # green
  green = list(~iterSums(FLQuant((SB / SBMSY) >= 1 & (F / FMSY) < 1)) / dim(SB)[6],
    name = "P(Green)", desc = "Probability of being in Kobe green quadrant"),
  # orange
  orange = list(~iterSums(FLQuant((SB / SBMSY) >= 1 & (F / FMSY) >= 1)) / dim(SB)[6],
    name = "P(Orange)", desc = "Probability of being in Kobe orange quadrant"),
  # yellow
  yellow = list(~iterSums(FLQuant((SB / SBMSY) < 1 & (F / FMSY) < 1)) / dim(SB)[6],
    name = "P(Yellow)", desc = "Probability of being in Kobe yellow quadrant"),
  # red
  red = list(~iterSums(FLQuant((SB / SBMSY) < 1 & (F / FMSY) >= 1)) / dim(SB)[6],
    name = "P(Red)", desc = "Probability of being in Kobe red quadrant")
)

save(indicators, kobeindicators, file="../data/indicators.RData", compress="xz")
