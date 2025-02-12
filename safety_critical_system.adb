package body Safety_Critical_System is
   protected body Data_Processor is
      entry Process_Traffic_Data(Data : in Traffic_Data)
         when Current_Status = Safe is
      begin
         -- Real-time data validation
         if not Is_Valid_Data(Data) then
            Current_Status := Unsafe;
            return;
         end if;
         
         -- Process traffic data with timing guarantees
         select
            delay 0.1; -- Hard real-time constraint
            Process_Data_With_Deadline(Data);
         or
            Current_Status := Unsafe;
         end select;
      end Process_Traffic_Data;
      
      function Get_Safety_Status return Safety_Status is
      begin
         return Current_Status;
      end Get_Safety_Status;
   end Data_Processor;
   
   task body Safety_Monitor is
      Period : constant Time_Span := Milliseconds(100);
   begin
      accept Start;
      loop
         select
            accept Stop;
            exit;
         or
            delay until Clock + Period;
            Check_System_Safety;
         end select;
      end loop;
   end Safety_Monitor;
end Safety_Critical_System;
