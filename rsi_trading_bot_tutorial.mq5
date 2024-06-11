//+------------------------------------------------------------------+
//|                                  RSI_EA_from_TradeOxy.mq5        |
//|                              AppnologyJames, TradeOxy.com        |
//|                                  https://www.tradeoxy.com        |
//+------------------------------------------------------------------+

// CTrade Class
#include <Trade\Trade.mqh>

input bool liveRSIPrice = false;                // Use live RSI price?
input int rsiHigh = 70;                         // RSI High threshold
input int rsiLow = 30;                          // RSI Low threshold
input int takeProfitPips = 20;                  // Take Profit in Pips
input int stopLossPips = 10;                    // Stop Loss in Pips
input double lotSize = 0.1;                     // Lot Size
input int concurrentTrades = 1;                 // Maximum number of concurrent trades

// Declare Global Variables
CTrade trade;                                   // Trade Object

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    // Print the name of the Expert Advisor and a Welcome message
    Print("RSI Trading Bot Expert Advisor from TradeOxy.com");
    // Return value of initialization
    return(INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
    // Deinitialization code
    Print("Expert advisor deinitialized. Reason: ", reason);
}


//+------------------------------------------------------------------+
//| GetRSI                                                           |
//+------------------------------------------------------------------+
double GetRSI()
{
    // Initialize a buffer
    double rsiBuffer[];
    // Make it into an array
    ArraySetAsSeries(rsiBuffer, true);
    // Get the RSI Handle
    int rsiHandle = iRSI(_Symbol, _Period, 14, PRICE_CLOSE);
    // If the handle is invalid, return 0
    if (rsiHandle == INVALID_HANDLE)
    {
        return(0);
    }
    // Copy the RSI values to the buffer
    int rsiCount = CopyBuffer(rsiHandle, 0, 0, 2, rsiBuffer);
    // If the copy failed, return 0
    if (rsiCount == 0)
    {
        return(0);
    }
    // Get the actual RSI value
    if(liveRSIPrice == true)
    {
        double rsi = rsiBuffer[0];
        return(rsi);
    }else{
        double rsi = rsiBuffer[1];
        return(rsi);
    }
}


//+------------------------------------------------------------------+
//| RSIAlgorithm Function                                            |
//+------------------------------------------------------------------+
string RSIAlgorithm(double rsiValue){
    // See if the value is below the 30 threshold
    if(rsiValue < rsiLow){
        return("BUY");
    // See if the value is above the 70 threshold
    }else if (rsiValue > rsiHigh){
        return("SELL");
    // Otherwise return HOLD
    }else{
        return("HOLD");
    }
}


//+------------------------------------------------------------------+
// OnSignal Function                                                 |
//+------------------------------------------------------------------+   
bool OnSignal(string signal){
    // Get the current ask price
    double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    // Get the pip size for the current symbol
    double pointSize = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
    // Multiply the point size by 10 to get pips
    double pipSize = pointSize * 10;
    // Get the Take Profit, which is the pipSize * takeProfitPips
    double takeProfitSize = pipSize * takeProfitPips;
    // Get the Stop Loss, which is the pipSize * stopLossPips
    double stopLossSize = pipSize * stopLossPips;
    if(signal == "BUY"){
        // Make the Take Profit above the current price
        double takeProfit = ask + takeProfitSize;
        // Make the Stop Loss below the current price
        double stopLoss = ask - stopLossSize;
        // Open a Buy Order
        trade.Buy(lotSize, _Symbol, ask, stopLoss, takeProfit, "RSI Tutorial EA");
        return(true);
    }else if(signal == "SELL"){
        // Make the Take Profit below the current price
        double takeProfit = ask - takeProfitSize;
        // Make the Stop Loss above the current price
        double stopLoss = ask + stopLossSize;
        // Open a Sell Order
        trade.Sell(lotSize, _Symbol, ask, stopLoss, takeProfit, "RSI Tutorial EA");
        return(true);
    }else if (signal == "HOLD"){
        return(true);
    }else{
        return(false);
    }
}


//+------------------------------------------------------------------+
//| TradeManagement Function                                         |
//+------------------------------------------------------------------+
bool TradeManagement(){
    // Get the total number of orders
    int totalOrders = OrdersTotal();
    // Get the total number of positions
    int totalPositions = PositionsTotal();
    // If there are no orders or positions, return true
    if(totalOrders == 0 && totalPositions == 0){
        return(true);
    }else{
        int totalTrades = totalOrders + totalPositions;
        if (totalTrades < concurrentTrades){
            return (true);
        }else{
            return (false);
        }
    }
}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
    bool tradeManagement = TradeManagement();
    if(tradeManagement == true){
        double rsi = GetRSI();
        string signal = RSIAlgorithm(rsi);
        bool success = OnSignal(signal);
    }
}
