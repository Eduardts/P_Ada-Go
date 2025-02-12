package Safety_Critical_System is
   type Traffic_Data is record
      Vehicle_ID   : String(1..16);
      Position     : Position_Type;
      Speed        : Speed_Type;
      Direction    : Direction_Type;
      Time_Stamp   : Time;
   end record;
   
   protected type Data_Processor is
      entry Process_Traffic_Data(Data : in Traffic_Data);
      function Get_Safety_Status return Safety_Status;
   private
      Current_Status : Safety_Status := Safe;
      Data_Queue    : Traffic_Queue;
   end Data_Processor;
   
   task type Safety_Monitor is
      entry Start;
      entry Stop;
   end Safety_Monitor;
end Safety_Critical_System;
