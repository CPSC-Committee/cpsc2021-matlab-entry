%%
% Written by: Caiyun Ma, Chengyu Liu
%             School of Instrument Science and Engineering
%             Southeast University, China
%             chengyu@seu.edu.cn
%%
function predict_endpoints = challenge(sample_path)
%  Predicted atrial fibrillation endpoints
%
% inputs
%   sample_path: The relative path where the recording is stored and refer to wfdb toolbox
% outputs
%   predict_endpoints: Predicted atrial fibrillation endpoints 
[signal,Fs,tm]=rdsamp(sample_path);
sig=signal(:,1);
y_seq=zeros(length(sig),1);
end_points=[];
[QRS,sign,en_thres] = qrs_detect(sig',0.25,0.6,Fs);
rr_seq=diff(QRS)/Fs;
len_rr=length(rr_seq);
t_unit=Fs*0.5;
is_af=[]
a=1;
n=len_rr/12;
q=rem(len_rr,12);
for i=1:n
    b=a+11;
    [cosEn,sentropy,mRR,minRR,medFreq] = comp_cosEn(rr_seq(a:b));
    if cosEn<-1.4 
        is_af(a:b)=0;
    end
    if cosEn==-1.4
        is_af(a:b)=0;
    end
    if cosEn>-1.4
        is_af(a:b)=1;
    end
    a=a+12;   
end
is_af_end=[];
if q~=0
    rr_seq_end=rr_seq(len_rr-11:len_rr)
   [cosEn,sentropy,mRR,minRR,medFreq] = comp_cosEn(rr_seq_end);
   if cosEn<-1.4 
        is_af_end(1:q)=0;
   end
   if cosEn==-1.4
        is_af_end(1:q)=0;
   end
    if cosEn>-1.4
        is_af_end(1:q)=1;
    end
end
is_af=[is_af,is_af_end];
if sum(is_af)==0
    y_class=0;
    points=[];
end
if sum(is_af)~=0 && sum(is_af)==length(is_af)
    y_class=2;
    y_seq=ones(length(sig),1);
    points=[1,length(sig)];
end
if (sum(is_af)>0 && sum(is_af)<length(is_af))
   y_class=1;
   for j=1:length(is_af)
       if is_af(j)==1
       y_seq(QRS(j):QRS(j+1)) =1;
       end
   end
yy=diff(is_af);
point=QRS(find(yy~=0)+1);
g1=0;
g2=0;
for z=1:length(point)
    if rem(z,2)==1
       g1=g1+1;
       start_points(g1,:)=point(z);
    end
    if rem(z,2)==0
       g2=g2+1;
       end_points(g2,:)=point(z);
    end
end
if rem(length(point),2)==1
   end_points=[end_points;length(sig)];
end
points=[start_points,end_points];
end
a=1;
for l=1:length(sig)/t_unit
    if sum(y_seq(a:a+t_unit-1))>1
       yy_seq(l,:)=1;
    end
    if sum(y_seq(a:a+t_unit-1))==0
       yy_seq(l,:)=0;
    end
     a=a+t_unit;  
end

predict_endpoints=points;


   
    



