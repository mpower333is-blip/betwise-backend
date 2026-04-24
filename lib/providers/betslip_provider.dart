import 'package:flutter/material.dart';
import '../models/bet_selection.dart';

class BetSlipProvider extends ChangeNotifier {

List<BetSelection> selections=[];

double stake=100;

void addSelection(BetSelection bet){

if(!selections.any((x)=>
x.game==bet.game &&
x.market==bet.market)){

selections.add(bet);
notifyListeners();
}

}

void removeSelection(BetSelection bet){
selections.remove(bet);
notifyListeners();
}

double get totalOdds {

double total=1;

for(var b in selections){
total*=b.odds;
}

return total;
}

double get payout{
return stake*totalOdds;
}

}