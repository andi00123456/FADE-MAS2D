function out = ctrldiscre(in)

%keyboard

NA = in(1);
apos = reshape(in(2:2*NA+1), NA, 2);
ctrlout = in(2*NA+2:3*NA+1);
M = in(end-5);
N = in(end-4);
U = in(end-3);
V = in(end-2);
hx = in(end-1);
tstar = in(end);
cpos_shift = tstar*hx*[U,V];

hx = 1/M;
hy = 1/N;
    
out = zeros((M-1)*(N-1),1);
for i = 1:NA
	i_pos = round((apos(i,1)+cpos_shift(1))/hx);	%convert actuator x coordination to integer between [0,M]
	j_pos = round((apos(i,2)+cpos_shift(2))/hy);	%convert actuator y coordination to integer between [0,N]
	if i_pos > M
        i_pos = M;
    end
    if j_pos > N
        j_pos = N;
    end
    if i_pos < 0
        i_pos = 0;
    end
     if j_pos < 0
        j_pos = 0;
    end
    %disp([i_pos,j_pos]);
    if i_pos==0 || i_pos==M || j_pos==0 || j_pos==N
		%if actuators are on the boundary, no control output
        %disp('On boundary');
		continue;
    end
	out((j_pos-1)*(M-1)+i_pos) = ctrlout(i);
end



