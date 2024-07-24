//+-----------------------------------------------------------------------+
//| EA from AppnologyJames                                            |
//+-----------------------------------------------------------------------+


// Input Parameters
input int MFI_Period = 14;         // Period of the Money Flow Index Indicator

//+------------------------------------------------------------------+
//| Expert Initialization function                                   |
//+------------------------------------------------------------------+
int OnInit(){
    // Print a series of = to delineate a new start
    Print("=====================================");
    // Print the EA name
    Print("EA from AppnologyJames. Hello World!");
    // Return value
    return(INIT_SUCCEEDED);
}


//+------------------------------------------------------------------+
//| Expert Deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason){
    // Print the EA name
    Print("EA from AppnologyJames. Goodbye World!");
    Print("Exit Reason: ", reason);
    // Print a series of = to delineate a new end
    Print("=====================================");
}


//+------------------------------------------------------------------+
//| Money Flow Index Indicator                                       |
//+------------------------------------------------------------------+
double MoneyFlowIndexIndicator(int candles_previous){
    // Create the buffer for the indicator
    double mfiBuffer[];
    // Convert into an array
    ArraySetAsSeries(mfiBuffer, true);
    // Get the handle for the indicator
    int mfiHandle = iMFI(_Symbol, 0, MFI_Period, VOLUME_TICK);
    // If the handle is invalid, return 0
    if(mfiHandle == INVALID_HANDLE){
        return 0;
    }
    // Copy the indicator data into the buffer
    int mfiCopy = CopyBuffer(mfiHandle, 0, 0, candles_previous + 1, mfiBuffer);
    // If the copy failed, return 0
    if(mfiCopy == 0){
        return 0;
    }
    // Return the MFI value
    return(mfiBuffer[candles_previous]);
}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
    // Print the EA name
    Print("EA from AppnologyJames. Tick!");
    // Print the MFI value
    Print("MFI: ", MoneyFlowIndexIndicator(1));
}
