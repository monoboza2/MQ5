//+------------------------------------------------------------------+
//|                                                        test3.mq5 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"

#include<Trade\Trade.mqh>
CTrade trade;

class Ma3sen{
   public:
   int limit;
   float lott;
   int takeprofit;
  
   void Indicatorna(){
      ArraySetAsSeries(ma1arr,true);
      ArraySetAsSeries(ma2arr,true);
      ArraySetAsSeries(ma3arr,true);
      ArraySetAsSeries(priceinfo,true);
     
     Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
     Bid=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
   
   signal="";
   data=CopyRates(_Symbol,_Period,0,3,priceinfo);
    ma1=iMA(_Symbol,_Period,20,0,MODE_EMA,PRICE_OPEN);
    ma2=iMA(_Symbol,_Period,50,0,MODE_EMA,PRICE_OPEN);
    ma3=iMA(_Symbol,_Period,200,0,MODE_EMA,PRICE_OPEN);
    
   CopyBuffer(ma1,0,0,3,ma1arr);
   CopyBuffer(ma2,0,0,3,ma2arr);
   CopyBuffer(ma3,0,0,3,ma3arr);
   
   }
   void show(){
   
     Ask=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_ASK),_Digits);
     Bid=NormalizeDouble(SymbolInfoDouble(_Symbol,SYMBOL_BID),_Digits);
      data=CopyRates(_Symbol,_Period,0,3,priceinfo);
      ma1=iMA(_Symbol,_Period,20,0,MODE_EMA,PRICE_OPEN);
      ma2=iMA(_Symbol,_Period,50,0,MODE_EMA,PRICE_OPEN);
      ma3=iMA(_Symbol,_Period,200,0,MODE_EMA,PRICE_OPEN);
   
      CopyBuffer(ma1,0,0,3,ma1arr);
      CopyBuffer(ma2,0,0,3,ma2arr);
      CopyBuffer(ma3,0,0,3,ma3arr);
      Comment(" ",Ask);
   }
   
   void order(){
   
      if(ma3arr[0]>priceinfo[0].close){
          if(ma1arr[0]>ma2arr[0]&&ma1arr[1]<ma2arr[1]){
            signal="buy";
         }
         else if(ma1arr[0]<ma2arr[0]&&ma1arr[1]>ma2arr[1]){
            signal="sell";
         }
         else{
            signal=" ";
         }
      }
     
      if(ma3arr[0]<priceinfo[0].close){
         if(ma1arr[0]>ma2arr[0]&&ma1arr[1]<ma2arr[1]){
            signal="buy";
         }
         else if(ma1arr[0]<ma2arr[0]&&ma1arr[1]>ma2arr[1]){
            signal="sell";
         }
         else{
            signal=" ";
         }
      }
      
   if(signal=="sell" && PositionsTotal()<limit){
      trade.Sell(lott,NULL,Bid,(Bid+2000*_Point),(Bid-takeprofit*_Point),NULL);
       }

   if(signal=="buy" && PositionsTotal()<limit){
       trade.Buy(lott,NULL,Ask,(Ask-2000*_Point),(Ask+takeprofit*_Point),NULL);
   }
   
   }
   
   double Ask;
   double Bid;
   int data;
   
   string signal;
   double myPricearr[];
   double ma1arr[];
   double ma2arr[];
   double ma3arr[];
   MqlRates priceinfo[];
  
   int ma1;
   int ma2;
   int ma3;
   
};

   
//+------------------------------------------------------------------+
