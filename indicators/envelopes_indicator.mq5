//+-----------------------------------------------------------------------+
//| EA from AppnologyJames                                            |
//+-----------------------------------------------------------------------+


// Input Parameters
input int EnvelopesPeriod = 14;         // Period of the Envelopes Indicator
input double EnvelopesDeviation = 0.00;       // Deviation from the middle band


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
//| Envelopes Indicator                                              |
//+------------------------------------------------------------------+
double EnvelopesIndicator(int candles_previous, string type){
    // Create the buffer for the indicator
    double envelopesBuffer[];
    // Convert into an array
    ArraySetAsSeries(envelopesBuffer, true);
    // Get the handle for the indicator
    int envelopesHandle = iEnvelopes(_Symbol, 0, EnvelopesPeriod, candles_previous, MODE_SMA, PRICE_CLOSE, EnvelopesDeviation);
    // Create the copy variable
    int envelopesCopy;
    // Create the array query variable
    int arrayQuery = candles_previous + 1;
    // If the handle is invalid, return 0
    if(envelopesHandle == INVALID_HANDLE){
        return 0;
    }
    if (type == "Upper"){
        // Copy the indicator data into the buffer
        envelopesCopy = CopyBuffer(envelopesHandle, 0, 0, arrayQuery, envelopesBuffer);
    }else if (type == "Lower"){
        // Copy the indicator data into the buffer
        envelopesCopy = CopyBuffer(envelopesHandle, 1, 0, arrayQuery, envelopesBuffer);
    }else{
        return 0;
    }
    
    // If the copy failed, return 0
    if(envelopesCopy == 0){
        return 0;
    }
    // Return the value of the indicator
    return envelopesBuffer[candles_previous];
}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
    // Print the EA name
    Print("EA from AppnologyJames. Tick!");
    // Get the value of the Envelopes Indicator
    double envelopesValue = EnvelopesIndicator(1, "Lower");
    // Print the value of the Envelopes Indicator
    Print("Envelopes Indicator: ", envelopesValue);
}
