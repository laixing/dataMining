function [label] = minimax_diameter(data, k)
N=size(data,1);
label = zeros(N, 1);
if k==2
    cents_21=data(ceil(rand(1,1)*N),:);
    max=0;
    for i=1:size(data,1)
        dal_2=norm(data(i,:)-cents_21(1,:));
        if dal_2 > max
            max=dal_2;
            cents_22=data(i,:);
        end
    end
    dal_22=zeros(size(data,1),k+2);
    for i=1:N
        dal_22(i,1)=norm(data(i,:)-cents_21);
        dal_22(i,2)=norm(data(i,:)-cents_22);
        [Distance CN]=min(dal_22(i,1:k));
        dal_22(i,k+1)=CN;
        dal_22(i,k+2)=Distance;
    end
    for i=1:N
        label(i,1)=dal_22(i,k+1);
    end
    plot(cents_21(:,1),cents_21(:,2),'*r','LineWidth',3);
    hold on
    plot(cents_22(:,1),cents_22(:,2),'*g','LineWidth',3);
    hold on
elseif k==3
    cents_21=data(ceil(rand(1,1)*N),:);
    max=0;
    for i=1:N
        dal_2=norm(data(i,:)-cents_21(1,:));
        if dal_2 > max
            max=dal_2;
            cents_22=data(i,:);
        end
    end
    max1=0;
    for i=1:N
        dal_31=norm(data(i,:)-cents_21(1,:));
        dal_32=norm(data(i,:)-cents_22(1,:));
        if dal_31>dal_32
            if dal_32>max1
                max1=dal_32;
                cents_23=data(i,:);
            end
        else
            if dal_31>max1
                max1=dal_31;
                cents_23=data(i,:);
            end
        end
    end
    
    dal_22=zeros(N,k+2);
    for i=1:size(data,1)
        dal_22(i,1)=norm(data(i,:)-cents_21);
        dal_22(i,2)=norm(data(i,:)-cents_22);
        dal_22(i,3)=norm(data(i,:)-cents_23);
    
        [Distance CN]=min(dal_22(i,1:k));
        dal_22(i,k+1)=CN;
        dal_22(i,k+2)=Distance;
    end
    for i=1:N
        label(i,1)=dal_22(i,k+1);
    end
    plot(cents_21(:,1),cents_21(:,2),'*r','LineWidth',3);
    hold on
    plot(cents_22(:,1),cents_22(:,2),'*g','LineWidth',3);
    hold on
    plot(cents_23(:,1),cents_23(:,2),'*b','LineWidth',3);
    hold on
    
end
visualize_result(data, label);
end

