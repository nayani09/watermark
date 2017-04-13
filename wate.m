clc
clear all
close all
alp=0.5;
I=imread('cameraman.tif');
figure,imshow(I);title('original image')
I=double(I);
I=imresize(I,[256 256]);
[m n c]=size(I);
B=imread('cameraman.tif');
B=imresize(B,[64 64]);
B=im2bw(B);
figure,imshow(B);title('Logo image')
B=double(B);
bsz=4;nb=size(I,1)/bsz;
for ii=0:nb-1
    for jj=0:nb-1
        blk=I(ii*bsz+[1:bsz],jj*bsz+[1:bsz]);
        m=round(mean2(blk));
        for i=1:bsz
            for j=1:bsz
                if blk(i,j)>m
                    O(i,j)=1;
                else
                    O(i,j)=0;
                end
            end
        end
                
    IO(ii*bsz+[1:bsz],jj*bsz+[1:bsz])=O;       
    end
end
k=1;
N=numel(B);
IW=I;
for i=1:m
    for j=1:n
        if k<=N
        if IO(i,j)==1
            IW(i,j)=I(i,j)+alp*B(k);
            k=k+1;        
        end
        end
    end
end
figure,imshow(uint8(IW));title('watermark image')
k=1;
for i=1:m
    for j=1:n
        if k<=N
        if IO(i,j)==1
            EW(k)=(I(i,j)-IW(i,j))/alp;
            k=k+1;        

        end

        end
    end
end
EW=reshape(abs(EW),[64 64]);
figure,imshow(EW);title('ext image')
        