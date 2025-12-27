int[] Ap = {2,3,5,6,7,8,10,11,12};
string[] A = sequence((new string(int i) {return "{" + ((string) Ap[i]) + "}";}),Ap.length);
size(11cm,11cm);
for(int i = 0; i < A.length; ++i){
    label("\(3^3\)", (30*i,0));
}
