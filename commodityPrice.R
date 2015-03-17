#Here I want to upload commodity prices from quandtl

rm(list = ls())
library(Quandl)
library(data.table)
library(ggplot2)
library(ggthemes)
library(zoo)

Quandl.auth("TE6qk7bjfVjrDuqVzs7A")

start = "1990-01-01"

##############
#SPOT PRICES##
##############
# COFFEE
# NOTE: In Brazil, +80% is arabica
# https://www.quandl.com/data/ODA/PCOFFOTM_USD-Arabica-Coffee-Price
coffee = Quandl('ODA/PCOFFOTM_USD',start_date = start)
coffee$crop = 'coffee'

# SOYBEANS
# https://www.quandl.com/data/ODA/PSOYB_USD-Soybeans-Price
# Source: IMF
soybean = Quandl('ODA/PSOYB_USD',start_date = start)
soybean$crop = 'soybean'
# ORANGES
# https://www.quandl.com/data/ODA/PORANG_USD-Oranges-Price
# ODA/PORANG_USD
# Source:IMF
orange = Quandl('ODA/PORANG_USD',start_date = start)
orange$crop = 'orange'
# SUGAR
# https://www.quandl.com/data/INDEXMUNDI/COMMODITY_SUGAR-Sugar-Monthly-Price
# INDEXMUNDI/COMMODITY_SUGAR
# Indexmundi
sugar = Quandl('INDEXMUNDI/COMMODITY_SUGAR',start_date = start)
names(sugar) = c('Date','Value')
sugar$crop = 'sugar'
# RICE
# https://www.quandl.com/data/ODA/PRICENPQ_USD-Rice-Price
# ODA/PRICENPQ_USD
rice = Quandl('ODA/PRICENPQ_USD',start_date = start)
rice$crop = 'rice'
# CORN (MAIZE)
# https://www.quandl.com/data/ODA/PMAIZMT_USD-Maize-Corn-Price
# ODA/PMAIZMT_USD
corn = Quandl('ODA/PMAIZMT_USD',start_date = start)
corn$crop = 'corn'
# COTTON
# https://www.quandl.com/data/ODA/PCOTTIND_USD-Cotton-Price
# ODA/PCOTTIND_USD
cotton = Quandl('ODA/PCOTTIND_USD',start_date = start)
cotton$crop = 'cotton'
# COCOA
# https://www.quandl.com/data/ODA/PCOCO_USD-Cocoa-beans-Price
cocoa = Quandl('ODA/PCOCO_USD',start_date = start)
cocoa$crop = 'cocoa'
# WHEAT
# https://www.quandl.com/data/ODA/PWHEAMT_USD-Wheat-Price
wheat = Quandl('ODA/PWHEAMT_USD',start_date = start)
wheat$crop = 'wheat'

prices = data.table(rbind(rice,corn,wheat,soybean,sugar,cocoa,orange,coffee))
prices[,movingAverageYear:=rollapply(Value,12,mean,fill=NA,align = 'left'),by='crop']

data = ts(prices)
data/lag(data,-1) - 1


