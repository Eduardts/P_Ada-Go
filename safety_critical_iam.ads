package Safety_Critical_IAM is
   type Access_Level is (None, Basic, Advanced, Admin);
   type Resource_Type is (Patient_Data, Medical_Device, Flight_Control);
   
   protected type Access_Controller is
      procedure Request_Access(
         User_ID     : in String;
         Resource    : in Resource_Type;
         Level       : in Access_Level;
         Grant       : out Boolean);
      procedure Revoke_Access(User_ID : in String);
   private
      Active_Sessions : Session_Map;
      Access_Log     : Log_Queue;
   end Access_Controller;
   
   task type Audit_Logger is
      entry Log_Event(Event : in Security_Event);
   end Audit_Logger;
end Safety_Critical_IAM;



