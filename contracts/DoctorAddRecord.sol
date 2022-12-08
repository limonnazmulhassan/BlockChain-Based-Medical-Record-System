
pragma solidity >=0.4.21 <0.7.0;
pragma experimental ABIEncoderV2;
 
contract DoctorAddRecord{

  //--- patient mapped to files added by doctor ---
  mapping (address => doctorAddedFiles[]) private doctorAddedPatientFiles;
  mapping (address => uint256) balanceOf;
  mapping (address => doctorOfferedConsultation[]) private doctorOfferedConsultationList;

  
 

  struct doctorAddedFiles{
    string file_name;
    string file_type;
    string file_hash;
    address doc_id;
  }

  // structure for doctor offered consultation
  struct doctorOfferedConsultation
  {
    address doc_id;
    string consultation_advice;
    string medicine;
    string time_period;
  }

  event doctorAddPatientFile(address _doctor, string msg, address _patient, uint gas_used);
  //--- function to add files from doctor end ---
  function doctorAddFiles(address _pat, string memory _file_name, string memory _file_type,string memory _file_hash) public
  {
    uint256 startGas = gasleft();  

    doctorAddedPatientFiles[_pat].push(doctorAddedFiles({file_name:_file_name, file_type:_file_type,file_hash:_file_hash, doc_id: msg.sender}));
      
    uint256 endGas = gasleft();
    uint256 gas_used = startGas-endGas;
    emit doctorAddPatientFile(msg.sender, "Added a file to patient record", _pat, gas_used);
  }

  function getDoctorAddedFiles(address pat) public view returns(doctorAddedFiles[] memory){
    return (doctorAddedPatientFiles[pat]);
  }


  event doctorOfferConsultation(address _doctor, string message, address _patient, string _consultation, string _medicine, uint256 gas_used);

  function addDoctorOfferedConsultation(address _pat, string memory _consultation, string memory _medicine, string  memory _time) public 
  {
    uint256 startGas = gasleft();
    doctorOfferedConsultationList[_pat].push(doctorOfferedConsultation({doc_id:msg.sender, consultation_advice:_consultation,medicine:_medicine,time_period:_time}));
    
    uint256 endGas = gasleft();
    uint256 gas_used = startGas-endGas;
    emit doctorOfferConsultation(msg.sender, "Provided consultation to", _pat, _consultation, _medicine, gas_used);
  }

  function getDoctorConsultation(address _pat)  public view returns (doctorOfferedConsultation[] memory){
    return (doctorOfferedConsultationList[_pat]);
  }

  
  function getDoctorConsultationForPatient()  public view returns (doctorOfferedConsultation[] memory){
    return (doctorOfferedConsultationList[msg.sender]);
  }
  
  
  
}