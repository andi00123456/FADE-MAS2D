%% preprocess 
% revised by Derek Hollenbeck 

%% variable checks
% just to make later programming easier
if ~exist('BDD', 'var')
	BDD = [];
end

if ~exist('BDN', 'var')
	BDN = [];
end

if ~exist('PD0', 'var')
	PD0 = [];
end

if ~exist('DPARA', 'var')
	DPARA = [];
end

%% seed for sensor noise
SEED_SNOISE = 0:(M-1)*(N-1)-1;

%% Define ZERO_SENSOR_NOISE
ZERO_SNOISE = zeros((M-1)*(N-1),1);

%% Construct the discrete matrix A
hx = 1/M;                       % spatial step size
hy = 1/N;
A=zeros((M-1)*(N-1));           % initialize A matrix 
fb = zeros([(M-1)*(N-1),1]);    % equavalent force coming from boundary condition
g=@(k) (-1)^k*gamma(alpha+1)/gamma(alpha/2-k+1)/gamma(alpha/2+k+1);
%g=@(k)gamma(k-alpha)/gamma(-alpha)/gamma(k+1);
h=-hx^alpha;

%keyboard

%% Define wind field RHS A matrix
% will implement later
% need a way to iterate in simulink loop.


%% Define RHS A matrix
% u = 0.1; v = 0.1;               % for constant wind implementation 
for j = 1:(N-1)                 % 每一行
	for i = 1:(M-1)             % 每一列
		if i~=1 && i~=(M-1)     % in x dirction, (i,j) is not next to a boundary point%i为列变化
			A((j-1)*(M-1)+i, (j-1)*(M-1)+i) = K*g(0)/h;     % point ij, k=0
            %Recvised by Kecai Cao 2016-11-09
            for m=1:i-1                                     % points i,j-k
                if m == 1
                   A((j-1)*(M-1)+i, (j-1)*(M-1)+i-m) = K*g(m)/h + U/(2*hx);% Effects of dots in half of the x direction 
                else
                    A((j-1)*(M-1)+i, (j-1)*(M-1)+i-m) = K*g(m)/h;% Effects of dots in half of the x direction
                end
            end
            for m=1:M-1-i                                   % points i,j+k
                if m == 1
                    A((j-1)*(M-1)+i, (j-1)*(M-1)+i+m) = K*g(m)/h - U/(2*hx); %Effects of dots in another half of the x direction
                else
                    A((j-1)*(M-1)+i, (j-1)*(M-1)+i+m) = K*g(m)/h; %Effects of dots in another half of the x direction
                end
            end
            % A((j-1)*(M-1)+i, (j-1)*(M-1)+i+1) = K*g(1)/h;
         elseif i==1                        %in x direction, (i,j) is next to a boundary point of x=0
			      ycord_bnd = hy*j;         % y coordination of the boundary point 
			      [bndtype, bndpara] = bndsearch([0,ycord_bnd], BDD, BDN); 
			      if bndtype==0
				  error(strcat('No boundary type definition for boundary point [0,', num2str(ycord_bnd),'].'))
		          elseif bndtype==1         %Dirichlet boundary 
				   c_bdd = bndpara(1);
                   A((j-1)*(M-1)+i,(j-1)*(M-1)+i) = K*g(0)/h;
                    % A((j-1)*(M-1)+i, (j-1)*(M-1)+i+1) = K*g(1)/h;
                    %A((j-1)*(M-1)+i, (j-1)*(M-1)+i+2) = K*g(2)/h; %By Jianxiong
                   for l=1:M-2				   
				   A((j-1)*(M-1)+i,(j-1)*(M-1)+i+l) = K*g(l)/h;%By Kecai 
                   end
                   fb((j-1)*(M-1)+i)=K*c_bdd/hx/hx;
		          else %Newmann boundary
				  c1_bdn = bndpara(1);
				  c2_bdn = bndpara(2);
				  A((j-1)*(M-1)+i,(j-1)*(M-1)+i) = (2*K-K/(1-hx*c2_bdn))*g(0)/h/2;%
				  %A((j-1)*(M-1)+i,(j-1)*(M-1)+i+1) = K*g(1)/h;
                  %A((j-1)*(M-1)+i,(j-1)*(M-1)+i+2) = K*g(2)/h;By Jianxiong
                  for l=1:M-2				   
				   A((j-1)*(M-1)+i,(j-1)*(M-1)+i+l) = K*g(l)/h;%By Kecai 
                   end
				  fb((j-1)*(M-1)+i) = K*c1_bdn/(1-hx*c2_bdn)/h;
                  end
		  else	%i==(M-1), (i,j) is next to a boundary point of x=1
			    ycord_bnd = hy*j; % y coordination of the boundary point 
			    [bndtype, bndpara] = bndsearch([1,ycord_bnd], BDD, BDN); 
                if bndtype==0
                    error(strcat('No boundary type definition for boundary point [1,', num2str(ycord_bnd),'].'))
			    elseif bndtype==1	%Dirichlet boundary 
                    c_bdd = bndpara(1);        
                    A((j-1)*(M-1)+i, (j-1)*(M-1)+i) = K*g(0)/h;
                    %A((j-1)*(M-1)+i, (j-1)*(M-1)+i+1) = K*g(1)/h;
                    %A((j-1)*(M-1)+i, (j-1)*(M-1)+i+2) = K*g(2)/h; Only effects of two dots has been used by jianxiong 
                    for k=1:M-2
                        A((j-1)*(M-1)+i, (j-1)*(M-1)+i-k) = K*g(k)/h;% effects of dots in x direction has been added by kecai
                    end
                    fb((j-1)*(M-1)+i) = K*c_bdd/h;
			    else	%Newmann boundary
                    c1_bdn = bndpara(1);
                    c2_bdn = bndpara(2);
                    A((j-1)*(M-1)+i, (j-1)*(M-1)+i) = (2*K-K/(1-hx*c2_bdn))*g(0)/h/2;%
                    % A((j-1)*(M-1)+i, (j-1)*(M-1)+i+1) = K*g(1)/h;
                    % A((j-1)*(M-1)+i, (j-1)*(M-1)+i+2) = K*g(2)/h;  Only effects of two dots has been used by jianxiong
                    for k=1:M-2
                        A((j-1)*(M-1)+i,(j-1)*(M-1)+i-k) = K*g(k)/h;   %g_{alpha,k+1};% effects of dots in x direction has been added by kecai
                    end
                    fb((j-1)*(M-1)+i) = K*c1_bdn/(1-hx*c2_bdn)/h;
                end
            end

		if j~=1 && j~=(N-1) %in y dirction, (i,j) is not next to a boundary point%j为行变化
			%keyboard
                A((j-1)*(M-1)+i, (j-1)*(M-1)+i) = A((j-1)*(M-1)+i,(j-1)*(M-1)+i) + ...
                    K*g(0)/h;
				%Revised By Kecai Cao 2016-11-09 Derek Hollenbeck
				%2021-01-08
                for n=1:j-1   
                    if n == 1
                        A((j-1)*(M-1)+i,(j-1)*(M-1)+i-n*(M-1)) = A((j-1)*(M-1)+i,(j-1)*(M-1)+i-n*(M-1)) + ...
                            K*g(n)/h + V/(2*hy); % effects of dots in left half of y direction
                    else
                        A((j-1)*(M-1)+i,(j-1)*(M-1)+i-n*(M-1)) = A((j-1)*(M-1)+i,(j-1)*(M-1)+i-n*(M-1)) + ...
                            K*g(n)/h; % effects of dots in left half of y direction
                    end
                end
                for n=1:N-1-j
                    if n == 1
                        A((j-1)*(M-1)+i,(j-1)*(M-1)+i+n*(M-1)) = A((j-1)*(M-1)+i,(j-1)*(M-1)+i+n*(M-1)) + ...
                            K*g(n)/h - V/(2*hy); % effects of dots in right half of y direction
                    else
                        A((j-1)*(M-1)+i,(j-1)*(M-1)+i+n*(M-1)) = A((j-1)*(M-1)+i,(j-1)*(M-1)+i+n*(M-1)) + ...
                            K*g(n)/h; % effects of dots in right half of y direction
                    end  
                end
		elseif j==1 %in y direction, (i,j) is next to a boundary point of y=0
                xcord_bnd = hx*i; %x coordination of the boundary point
                [bndtype, bndpara] = bndsearch([xcord_bnd,0], BDD, BDN); 
                if bndtype==0
                    error(strcat('No boundary type definition for boundary point [', num2str(xcord_bnd),'0].'))
                elseif bndtype==1	%Dirichlet boundary 
                        c_bdd = bndpara(1);
                        A((j-1)*(M-1)+i,(j-1)*(M-1)+i)=A((j-1)*(M-1)+i,(j-1)*(M-1)+i)+K*g(0)/h;
                        %A((j-1)*(M-1)+i,(j-1)*(M-1)+i+(N-1))=K*g(1)/h;%Only effects of one dot used by jianxiong
                       for l=1:N-2	
                            A((j-1)*(M-1)+i,(j-1)*(M-1)+i+l*(M-1))= A((j-1)*(M-1)+i,(j-1)*(M-1)+i+l*(M-1)) + ...
                                K*g(l)/h; %effects of dots in right half of y direction
                       end                        
                        fb((j-1)*(M-1)+i)= fb((j-1)*(M-1)+i)+K*c_bdd/h;
                else %Newmann boundary
                        c1_bdn = bndpara(1);
                        c2_bdn = bndpara(2);
                        A((j-1)*(M-1)+i,(j-1)*(M-1)+i) = A((j-1)*(M-1)+i,(j-1)*(M-1)+i) + ...
                            (2*K-K/(1-hy*c2_bdn))*g(0)/h/2;
                        %A((j-1)*(M-1)+i,(j-1)*(M-1)+i+(N-1)) = K*g(1)/h;%Only effects of one dot used by jianxiong
                        for l=1:N-2	
                            A((j-1)*(M-1)+i,(j-1)*(M-1)+i+l*(M-1))= A((j-1)*(M-1)+i,(j-1)*(M-1)+i+l*(M-1)) + ...
                                K*g(l)/h; %effects of dots in right half of y direction
                       end  
                        fb((j-1)*(M-1)+i) = fb((j-1)*(M-1)+i) + K*c1_bdn/(1-hy*c2_bdn)/h;
                end
		   else	%j==(N-1), (i,j) is next to a boundary point of y=1
                   xcord_bnd = hx*i; %x coordination of the boundary point
                   [bndtype, bndpara] = bndsearch([xcord_bnd,1], BDD, BDN);
			
                   if bndtype==0
                       error(strcat('No boundary type definition for boundary point [', num2str(xcord_bnd),'1].'))
                   elseif bndtype==1	%Dirichlet boundary
                           c_bdd = bndpara(1);
                           A((j-1)*(M-1)+i,(j-1)*(M-1)+i) = A((j-1)*(M-1)+i,(j-1)*(M-1)+i) +K*g(0)/h;
                           for k=1:N-2
                               A((j-1)*(M-1)+i,(j-1)*(M-1)+i-k*(M-1)) = A((j-1)*(M-1)+i,(j-1)*(M-1)+i-k*(M-1)) + ...
                                   K*g(k)/h; % in left part of y direction
                           end
                           fb((j-1)*(M-1)+i) = fb((j-1)*(M-1)+i) + K*c_bdd/h;
                   else %Newmann boundary
                           c1_bdn = bndpara(1);
                           c2_bdn = bndpara(2);
                           A((j-1)*(M-1)+i,(j-1)*(M-1)+i) = A((j-1)*(M-1)+i,(j-1)*(M-1)+i) + (2*K-K/(1-hy*c2_bdn))*g(0)/h/2;
                           for k=1:N-2
                               A((j-1)*(M-1)+i,(j-1)*(M-1)+i-k*(N-1)) = A((j-1)*(M-1)+i,(j-1)*(M-1)+i-k*(N-1)) + ...
                                   K*g(k)/h; % in left part of y direction
                           end
                           fb((j-1)*(M-1)+i) = fb((j-1)*(M-1)+i) + K*c1_bdn/(1-hy*c2_bdn)/h;
                   end
            end
	end
end
%A matrix ready!
%generate 1D version of PA0, VA0, PS0, VS0, and PD0
size_PA0 = size(PA0);
size_VA0 = size(VA0);
size_PS0 = size(PS0);
size_VS0 = size(VS0);
size_PD0 = size(PD0);

PA0_1d = reshape(PA0, size_PA0(1)*size_PA0(2), 1);
VA0_1d = reshape(VA0, size_VA0(1)*size_VA0(2), 1);
PS0_1d = reshape(PS0, size_PS0(1)*size_PS0(2), 1);
VS0_1d = reshape(VS0, size_VS0(1)*size_VS0(2), 1);
PD0_1d = reshape(PD0, size_PD0(1)*size_PD0(2), 1);

DEXTRA = [length(DPARA);DPARA(:)];
