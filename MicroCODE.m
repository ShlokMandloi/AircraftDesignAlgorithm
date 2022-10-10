payload = 0; %lbs

friction = 0.05;
e = 2.71828;
fuse_width = 0;
liftFactor = 0.8;
emptyWt = 2; %lbs
Nsmall = 0;
Nlarge = 3;
mass = emptyWt +  0.34375*Nlarge + 0.15625*Nsmall;
bonus = 0.5 + 1*Nlarge + 0.4*Nsmall;

%%%%%%%%avionics inputs
staticThrust = 2.6; %kg
dia = 16;
pitch = 6;
rpm = 6600;
ve_theo = (rpm*0.0254*pitch)/60;
exit = 19.04; 

staticThrustN = staticThrust*9.8 ;
alpha = staticThrustN/(exit^2);




span = 48;
rootChord = 12;
tipChord = 12;
rectangularPercentage = 100;
cl = 0.933;
cd = 0.1235;
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;


 takeoffDistance = 0;
while(takeoffDistance<=8)
    payload = payload+0.001;
    allUpWeight = payload + emptyWt;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = 0.8* vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;
takeofftime = log(abs((sqrt(A)+vLift*sqrt(B))/(sqrt(A)-vLift*sqrt(B))))/(2*sqrt(A*B));
disp(['TakeOff Distance: ',num2str(takeoffDistance),',','Payload: ',num2str(payload)])
end

    u = vLift;
    k =0;
    t =0;
    while(k<=89.0016)
        t= t+0.001;
        thrust = staticThrustN - alpha*u^2;
        drag = 0.5*1.225*area*u^2*cd;
   
    a = (thrust - drag)*2.2/allUpWeight;
    v = u + a*0.001;
    s = u*0.001 + 0.5*a*0.001^2;
     u=v;
    k = k+s;
    end
     totaltime = takeofftime + t;
    Treg = totaltime *3.217 - 12.09;
       
        v300 = v;
    score = 80*sqrt(payload)*sqrt(bonus)/totaltime;
       disp(['Span: ',num2str(A),' , ','Chord: ',num2str(B),',',' Payload: ',num2str(payload),' , ','Score: ',num2str(score), ' , ',' All up: ',num2str(allUpWeight),',',' v300: ',num2str(v300),',', ' time: ',num2str(totaltime)]);