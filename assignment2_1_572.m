clc
clear all
close all
filename='overdoses.csv';
T=readtable(filename);
A=table2array(T);
X=table2array(T(:,2));
Y=table2array(T(:,3));
X=str2double(X);
Y=str2double(Y);
C=[X(:),Y(:)];
J=zeros(14,1);
for m=2:15
    
    k=m;
    kmi=50;
    cents=C(ceil(rand(k,1)*size(C,1)),:);
    dal=zeros(size(C,1),k+2);
    CV    = '+r+b+c+m+k+yorobocomokoysrsbscsmsksy';

    for n=1:kmi
        for i=1:size(C,1)
            for j=1:k
                dal(i,j)=norm(C(i,:)-cents(j,:));
            end
            [Distance CN]=min(dal(i,1:k));
            dal(i,k+1)=CN;
            dal(i,k+2)=Distance;
        end
        
        for i=1:k
            for j=1:50
                if(dal(j,k+1)==i)
                    J(m-1,1)=J(m-1,1)+(norm(C(j,:)-cents(i,:))).^2;
                end
            end
        end
            
        for i=1:k
            B=(dal(:,k+1)==i);
            cents(i,:)=mean(C(B,:));
            if sum(isnan(cents(:)))~=0
                NC=find(isnan(cents(:,1))==1);
                for Ind=1:size(NC,1)
                    cents(NC(Ind),:)=C(randi(size(C,1)),:);
                end
            end
        end
        

        clf
        figure(m-1)
        hold on
        for i = 1:k
            PT = C(dal(:,k+1) == i,:);                            % Find points of each cluster    
            plot(PT(:,1),PT(:,2),CV(2*i-1:2*i),'LineWidth',0.5);    % Plot points with determined color and shape
            plot(cents(:,1),cents(:,2),'*k','LineWidth',3);       % Plot cluster centers
        end
        hold off
        grid on
        pause(0.1)
        saveas(figure(m-1),sprintf('fig%d',m-1));
        close(figure(m-1));
    end    
    
end
clf
figure(15)
hold on
plot(2:1:15,J);
saveas(figure(15),'figure15');
    
