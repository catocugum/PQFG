#######################################################################################################
##
## Persephone Risk & Performance Management
##
## backtest control script
##
## (c) 2017 Persephone Quantitative Finance Group GmbH
##
## Author: Gregor Povh
##
#######################################################################################################



library(reshape2)
library(futile.logger)
library(openxlsx)
library(timeSeries)
library(yaml)
library(rugarch)
library(VineCopula)




source("R/o_setGeneric.R")
source("R/o_MarketData.R")
source("R/o_InstrumentData.R")
source("R/o_Universe.R")
source("R/o_PortfolioStatus.R")
source("R/o_Portfolio.R")
source("R/o_Backtest.R")
source("R/o_Constraints.R")
source("R/o_PDEopt.R")
source("R/g_Functions.R")



#######################################################################################################
# Load configurations
#######################################################################################################

g_cfg <- loadGlobalConfiguration("config.etf.weekly.yml")


#######################################################################################################
# market data 
#######################################################################################################

g_l_marketData <- list()
g_l_marketData <- append(g_l_marketData, loadAriva())
g_l_marketData <- append(g_l_marketData, loadCioIndices())
g_l_marketData <- append(g_l_marketData, createIndexInstruments())





#######################################################################################################
# backtest
#######################################################################################################

name <- "bt_etf"


name <- paste0(Sys.Date(), ".", name)

bt <- new("Backtest", name = name)

bt <- runBacktest(bt)

save(bt, file = paste0("results/", name, ".RData"))




