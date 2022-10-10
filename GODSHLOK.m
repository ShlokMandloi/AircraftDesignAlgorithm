payload = 0; %lbs
friction = 0.1;
e = 2.71828;
fuse_width = 10.3;
liftFactor = 0.76;

%%%%%%%%avionics inputs
%%SunnySky X5320
staticThrust = 6; %kg
%%dia = 21;
%%pitch = 12;
%%rpm = 3800;
%%ve_theo = (rpm*0.0254*pitch)/60;
ve_prac = 23.51;
%%exit = (ve_theo + ve_prac)/2;
exit = ve_prac;

staticThrustN = staticThrust*9.8;
alpha = staticThrustN/(exit^2);

%%%%%%%%%%%%%%%%

wingConfig = xlsread('FULLDESIGNPOINTS.xlsx','A2:J454'); %change file location accoring to your excel

wingData = wingConfig(:,:);

%%%%%%%%%%%%%% ONE BALL CONFIG
S = 1; %no of spherical balls
cargoLength = 9; %inches

for a = 1:1:453 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);
normalarea = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100)));


AR = (span*span)/normalarea;

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 8.5 + 0.938*S;
    %%FUSE DRAG
    cd_fuse = 0.15;
    
    %%%%%%%%%%%
end
if(span==70)
    mass = 9.5 + 0.938*S;
    %%FUSE DRAG
    cd_fuse = 0.14;
    
    %%%%%%%%%%%    
end
if(span==80)
    mass = 9.8 + 0.938*S;
    %%FUSE DRAG
    cd_fuse = 0.13;
    
    %%%%%%%%%%%     
end
if(span==90)
    mass = 10.6 + 0.938*S;
    %%FUSE DRAG
    cd_fuse = 0.12;
    
    %%%%%%%%%%%      
end
if(span==100)
    mass = 11.4 + 0.938*S;
    %%FUSE DRAG
    cd_fuse = 0.11;
    
    %%%%%%%%%%%  
end
if(span==110)
    mass = 12.2 + 0.938*S;
    %%FUSE DRAG
    cd_fuse = 0.10;
    
    %%%%%%%%%%%  
end
if(span==120)
    mass = 13 + 0.938*S;
    %%FUSE DRAG
    cd_fuse = 0.09;
    
    %%%%%%%%%%%      
end


takeoffDistance = 0;
while(takeoffDistance <=95 )
    
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd+cd_fuse-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;



end
cargoWeight = payload+ 0.25; %% 0.25 for extra elex weight


FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' , ',' vLift: ',num2str(vLift),' , ',' 1 BALL']);

payload = 0;

end



%%%%%%%%%%%%%% TWO BALL HORIZONTAL CONFIG
S = 2; %no of spherical balls
cargoLength = 18; %inches

for a = 1:1:453 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 9 + 0.938*S + 0.2;
    %%FUSE DRAG
    cd_fuse = 0.175;
    
    %%%%%%%%%%%   
end
if(span==70)
    mass = 9.5 + 0.938*S +0.2 ;
    %%FUSE DRAG
    cd_fuse = 0.165;
    
    %%%%%%%%%%%   
end
if(span==80)
    mass = 9.8 + 0.938*S +0.2 ;
    %%FUSE DRAG
    cd_fuse = 0.155;
    
    %%%%%%%%%%% 
end
if(span==90)
    mass = 10.6 + 0.938*S + 0.2;
    %%FUSE DRAG
    cd_fuse = 0.145;
    %%%%%%%%%%% 
end
if(span==100)
    mass = 11.4 + 0.938*S + 0.2;
    %%FUSE DRAG
    cd_fuse = 0.135;
 
    %%%%%%%%%%% 
end
if(span==110)
    mass = 12.2 + 0.938*S +0.2 ;
    %%FUSE DRAG
    cd_fuse = 0.125;
    
    %%%%%%%%%%% 
end
if(span==120)
    mass = 13 + 0.938*S + 0.2 ;
    %%FUSE DRAG
    cd_fuse = 0.115;
    
    %%%%%%%%%%% 
end

 
takeoffDistance = 0;
while(takeoffDistance <=95 )
    
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd+cd_fuse-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;


end
cargoWeight = payload;


FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' , ',' vLift: ',num2str(vLift),' , ',' 2 BALL HORIZONTAL']);

payload = 0;

end


%%%%%%%%%%%%%% TWO BALL VERTICAL CONFIG
S = 2; %no of spherical balls
cargoLength = 9; %inches

for a = 1:1:453 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 8.6 + 0.938*S + 0.2;
    %%FUSE DRAG
    cd_fuse = 0.3;
    
    %%%%%%%%%%% 
end
if(span==70)
    mass = 9.1 + 0.938*S +0.2 ;
    %%FUSE DRAG
    cd_fuse = 0.28;
    
    %%%%%%%%%%% 
end
if(span==80)
    mass = 9.8 + 0.938*S +0.2 ;
    %%FUSE DRAG
    cd_fuse = 0.26;
    
    %%%%%%%%%%% 
end
if(span==90)
    mass = 10.6 + 0.938*S + 0.2;
    %%FUSE DRAG
    cd_fuse = 0.24;
    
    %%%%%%%%%%% 
end
if(span==100)
    mass = 11.4 + 0.938*S + 0.2;
    %%FUSE DRAG
    cd_fuse = 0.22;
    
    %%%%%%%%%%% 
end
if(span==110)
    mass = 12.2 + 0.938*S +0.2 ;
    %%FUSE DRAG
    cd_fuse = 0.2;
    
    %%%%%%%%%%% 
end
if(span==120)
    mass = 13 + 0.938*S + 0.2 ;
    %%FUSE DRAG
    cd_fuse = 0.18;
    
    %%%%%%%%%%% 
end

 
takeoffDistance = 0;
while(takeoffDistance <=95 )
    
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd+cd_fuse-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;



end
cargoWeight = payload;


FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' , ',' vLift: ',num2str(vLift),' , ','2 BALL VERTICAL']);

payload = 0;

end

%%%%%%%%%%%%%% THREE BALL TRIANGLE CONFIG
S = 3; %no of spherical balls
cargoLength = 18; %inches

for a = 1:1:453 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 8.6 + 0.938*S + 0.4;
    %%FUSE DRAG
    cd_fuse = 0.4;
    
    %%%%%%%%%%% 
end
if(span==70)
    mass = 9.1 + 0.938*S +0.4;
    %%FUSE DRAG
    cd_fuse = 0.38;
    
    %%%%%%%%%%% 
end
if(span==80)
    mass = 9.8 + 0.938*S +0.4;
    %%FUSE DRAG
    cd_fuse = 0.36;
    
    %%%%%%%%%%% 
end
if(span==90)
    mass = 10.6 + 0.938*S + 0.4;
    %%FUSE DRAG
    cd_fuse = 0.34;
    
    %%%%%%%%%%% 
end
if(span==100)
    mass = 11.4 + 0.938*S + 0.4;
    %%FUSE DRAG
    cd_fuse = 0.32;
    
    %%%%%%%%%%% 
end
if(span==110)
    mass = 12.2 + 0.938*S +0.4;
    %%FUSE DRAG
    cd_fuse = 0.3;
    
    %%%%%%%%%%% 
end
if(span==120)
    mass = 13 + 0.938*S + 0.6;
    %%FUSE DRAG
    cd_fuse = 0.28;
    
    %%%%%%%%%%% 
end

 
takeoffDistance = 0;
while(takeoffDistance <=95 )
    
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd+cd_fuse-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;



end
cargoWeight = payload;


FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' , ',' vLift: ',num2str(vLift),' , ','3 BALL']);

payload = 0;

end

%%%%%%%%%%%%%% FOUR BALL SQUARE CONFIG
S = 4; %no of spherical balls
cargoLength = 18; %inches

for a = 1:1:453 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 8.6 + 0.938*S + 0.5;
    %%FUSE DRAG
    cd_fuse = 0.45;
    
    %%%%%%%%%%% 
end
if(span==70)
    mass = 9.1 + 0.938*S +0.5;
    %%FUSE DRAG
    cd_fuse = 0.43;
    
    %%%%%%%%%%% 
end
if(span==80)
    mass = 9.8 + 0.938*S +0.7;
    %%FUSE DRAG
    cd_fuse = 0.41;
    
    %%%%%%%%%%% 
end
if(span==90)
    mass = 10.6 + 0.938*S + 0.7;
    %%FUSE DRAG
    cd_fuse = 0.39;
    
    %%%%%%%%%%% 
end
if(span==100)
    mass = 11.4 + 0.938*S + 0.7;
    %%FUSE DRAG
    cd_fuse = 0.37;
    
    %%%%%%%%%%% 
end
if(span==110)
    mass = 12.2 + 0.938*S +0.7;
    %%FUSE DRAG
    cd_fuse = 0.35;
    
    %%%%%%%%%%% 
end
if(span==120)
    mass = 13 + 0.938*S + 0.9;
    %%FUSE DRAG
    cd_fuse = 0.33;
    
    %%%%%%%%%%% 
end

 
takeoffDistance = 0;
while(takeoffDistance <=95 )
    
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd+cd_fuse-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;



end
cargoWeight = payload;


FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' , ',' vLift: ',num2str(vLift),' , ','4 BALL']);

payload = 0;

end

%%%%%%%%%%%%%% FIVE BALL TRIANGLE CONFIG
S = 5; %no of spherical balls
cargoLength = 27; %inches

for a = 1:1:453 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 8.6 + 0.938*S + 1.2;
    %%FUSE DRAG
    cd_fuse = 0.5;
    
    %%%%%%%%%%% 
end
if(span==70)
    mass = 9.1 + 0.938*S +1.2 ;
    %%FUSE DRAG
    cd_fuse = 0.48;
    
    %%%%%%%%%%% 
end
if(span==80)
    mass = 9.8 + 0.938*S +1.3 ;
    %%FUSE DRAG
    cd_fuse = 0.46;
    
    %%%%%%%%%%% 
end
if(span==90)
    mass = 10.6 + 0.938*S + 1.3;
    %%FUSE DRAG
    cd_fuse = 0.44;
    
    %%%%%%%%%%% 
end
if(span==100)
    mass = 11.4 + 0.938*S + 1.3;
    %%FUSE DRAG
    cd_fuse = 0.42;
    
    %%%%%%%%%%% 
end
if(span==110)
    mass = 12.2 + 0.938*S +1.2 ;
    %%FUSE DRAG
    cd_fuse = 0.40;
    
    %%%%%%%%%%% 
end
if(span==120)
    mass = 13 + 0.938*S + 1.4 ;
    %%FUSE DRAG
    cd_fuse = 0.38;
    
    %%%%%%%%%%% 
end

 
takeoffDistance = 0;
while(takeoffDistance <=95 )
    
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd+cd_fuse-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;



end
cargoWeight = payload;


FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' , ',' vLift: ',num2str(vLift),' , ','5 BALL']);

payload = 0;

end

%%%%%%%%%%%%%% SIX BALL RECTANGLE CONFIG
S = 6; %no of spherical balls
cargoLength = 27; %inches

for a = 1:1:453 %%%%%%%%%%%%%% change end point of 'a' accoring to number of rows of excel
design_point = wingData(a,1);
span = wingData(a,2);
rootChord = wingData(a,3);
tipChord = wingData(a,4);
rectangularPercentage = wingData(a,5);
cl = wingData(a,9);
cd = wingData(a,10);
area = 0.00064516*((span*((rectangularPercentage*rootChord)+0.5*(100-rectangularPercentage)*(rootChord+tipChord))/(100))-fuse_width*rootChord);

 
dynamicThrust = staticThrustN;
if(span==60)
    mass = 8.6 + 0.938*S + 1.4;
    %%FUSE DRAG
    cd_fuse = 0.4; %%0.5878689;
    
    %%%%%%%%%%% 
end
if(span==70)
    mass = 9.1 + 0.938*S +1.4;
    %%FUSE DRAG
    cd_fuse = 0.38;%%0.503328102;
    
    %%%%%%%%%%% 
end
if(span==80)
    mass = 9.8 + 0.938*S +1.6;
    %%FUSE DRAG
    cd_fuse = 0.36;%%0.445048231;
    
    %%%%%%%%%%% 
end
if(span==90)
    mass = 10.6 + 0.938*S + 1.6;
    %%FUSE DRAG
    cd_fuse = 0.34;
    
    %%%%%%%%%%% 
end
if(span==100)
    mass = 11.4 + 0.938*S + 1.6;
    %%FUSE DRAG
    cd_fuse = 0.32;
    
    %%%%%%%%%%% 
end
if(span==110)
    mass = 12.2 + 0.938*S +1.6;
    %%FUSE DRAG
    cd_fuse = 0.30;
    
    %%%%%%%%%%% 
end
if(span==120)
    mass = 13 + 0.938*S + 1.7;
    %%FUSE DRAG
    cd_fuse = 0.28;
    
    %%%%%%%%%%% 
end

 
takeoffDistance = 0;
while(takeoffDistance <=95 )
    
    payload = payload+0.0005;
    allUpWeight = payload + mass;

vStall = sqrt((2*allUpWeight*9.8)/(1.225*area*cl*2.2));
vLift = liftFactor * vStall;
dynamicThrust = staticThrustN - (alpha*vLift^2);


%%%%%%%%%%% integral constant calculation:
A = (((staticThrustN*2.2)/allUpWeight)-(friction*9.81));
B = ((1.225*area*0.5*(cd+cd_fuse-(friction*cl)) + alpha)*2.2)/allUpWeight;
%%%%%%%%%%%%%%%%%%%%%

takeoffDistance = ((log(abs(A)/abs((A-(B*(vLift^2))))))/(2*B))*3.28;



end
cargoWeight = payload;


FS = 120*((3*S + cargoWeight)/(span + cargoLength));
netWeight = cargoWeight + mass;

disp(['Design Point: ',num2str(design_point),' , ','Span: ',num2str(span),' , ','RC: ',num2str(rootChord),' , ','TC: ',num2str(tipChord),' , ','rect%: ',num2str(rectangularPercentage),' , ','cl: ',num2str(cl),' , ','cd: ',num2str(cd),' , ',' Payload: ',num2str(payload),' , ','Score: ',num2str(FS), ' , ',' All up: ',num2str(netWeight),' , ',' vLift: ',num2str(vLift),' , ','6 BALL']);

payload = 0;

end

