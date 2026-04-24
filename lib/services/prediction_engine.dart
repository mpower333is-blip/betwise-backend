class PredictionEngine {

static double betwiseRating({
required double form,
required double value,
required double market,
required double teamNews,
required double model,
}) {

return
(form*.25)+
(value*.25)+
(market*.20)+
(teamNews*.15)+
(model*.15);

}

static String grade(
double rating
){

if(rating>=85){
return "ELITE";
}

if(rating>=75){
return "A+";
}

if(rating>=65){
return "A";
}

if(rating>=55){
return "B";
}

return "PASS";
}

}