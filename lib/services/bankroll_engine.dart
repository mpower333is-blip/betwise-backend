class BankrollEngine {

  static String stakeSize(
      int confidence
      ) {

    if(confidence>=85){
      return "5%";
    }

    if(confidence>=78){
      return "3%";
    }

    return "2%";
  }

}