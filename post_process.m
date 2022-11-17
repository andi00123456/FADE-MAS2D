%Sean had added some code in this function.(Jianxiong 11/22/2013)
	fig = figure(1);
    axis tight manual
	u_2d = [];
	x = 1/M:1/M:(1-1/M);
	y =	 1/N:1/N:(1-1/N);
	[X,Y] = meshgrid(x,y);

    tout = simout.tout;
    t = simout.t;
    udot = simout.udot;
    u = simout.u;
    smove = simout.smove;
    dinfo = simout.dinfo;
    amove = simout.amove;
    ActuatorDes = simout.ActuatorDes;
    Control_Input = simout.Control_Input;
    acceleration = simout.acceleration;

	length_t = length(t);
	for k = 1:PLOTSTEP:length_t
% 		subplot(1,2,1)
% 		u_2d = reshape(u(k,:),M-1,N-1)';
% 		surf(X, Y, u_2d);
% 		xlabel('x')
% 		ylabel('y')
% 		zlabel('u')
% 		caxis([-0.3, 0.8])
% 		axis([0, 1, 0, 1, -0.1, 1.1])
% 		colorbar
% 		if k < 10
% 			fname = strcat('000', num2str(k),'.jpg');
% 		elseif  k >= 10 && k < 100
% 			fname = strcat('00', num2str(k),'.jpg');
% 		elseif k >= 100 && k < 1000
% 			fname = strcat('0', num2str(k),'.jpg');
% 		else
% 			fname = strcat(num2str(k), '.jpg');
%         end
% 		subplot(1,2,2)
		for i = 1:NS
            if (u(k,NS+1-i) > 0.01)
                plot(smove(k,i), smove(k,i+NS),'gx','linewidth',2);
            elseif (u(k,NS+1-i) < -0.01)
                plot(smove(k,i), smove(k,i+NS),'yx','linewidth',2);
            else
                plot(smove(k,i), smove(k,i+NS),'bx','linewidth',1);
            end
            % plot(smove(k,i), smove(k,i+NS),'gx');
			hold on
        end
        xlabel(num2str(t(k)))
		axis([0,1,0,1]);
		axis square;
        
%         %Added by Sean Rider 8/14/13
%         xend = zeros(NA);
%         yend = zeros(NA);
%         %%%%

		for i = 1:NA
			plot(1-amove(k,i+NA),1-amove(k,i), 'kd','linewidth',2);
			hold on
            % added 2006/09/02 to display desired positions of actuators
            plot(ActuatorDes(k,i), ActuatorDes(k,i+NA),'ro');
            
             %Added by Sean Rider 8/14/13
             % xend(i) = amove(end, i);
             % yend(i) = amove(end,i+NA);

             xend(i) = ActuatorDes(k,i);
             yend(i) = ActuatorDes(k,i+NA);
             %%%%
			hold on
        end
        
         if k>1
        %Added by Sean Rider 8/14/13
        vxy(:,1) = xend';
        vxy(:,2) = yend';
        [vx,vy] = voronoi(xend,yend);
        % plot(vx,vy,'r-',xend,yend,'ro');
        plot(vx,vy,'r-');
        %%%%
        end
        
        
     	for i = 1:ND
			plot(dinfo(k,i), dinfo(k,i+ND),'r*');
			hold on
		end
		hold off

		%print('-djpeg', '-r72', fname);
		%saveas(gcf, strcat(fname,'.fig'), 'fig')
		%mv(k) = getframe(gcf);
        
        frame = getframe(fig);
        im = frame2im(frame);
        [imind,cm] = rgb2ind(im,256);
      if k == 1   
          imwrite(imind,cm,'two_new_movie.gif','gif', 'Loopcount',inf);
      else
        imwrite(imind,cm,'two_new_movie.gif','gif','WriteMode','append');
      end
%shg
	end


