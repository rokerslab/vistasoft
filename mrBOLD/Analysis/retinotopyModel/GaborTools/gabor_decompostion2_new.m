
clear all
close all
%Setting variables to parameters
img=imread('synthetic1.png');            
if length(size(img))==3             %generalized to rgb images
    img=rgb2gray(img);
end
img= double(img);
figure;imshow(img,[])

p=0;
phi=1;  % for 1.5 octave bandwidth
K = sqrt(2*log(2))*((2^phi+1)/(2^phi-1)); % for phi denoting spatial freq bandwidth
%{ admissible phi for simple and complex cells found 2 b in [0.5 2.5] }

%w0_deg=[8 16 32 64 128];
w0_deg=[8 16 32];
%theta_deg=[0 22.5 45 67.5 90 112.5 135 157.5];
theta_deg=[45 67.5];

%w0=[8 16 32 64 128].*(pi/180); 
w0=[8 16 32].*(pi/180); 
%theta=[0 22.5 45 67.5 90 112.5 135 157.5].*(pi/180);
theta=[45 67.5].*(pi/180);

len_w0=length(w0);
len_theta=length(theta);

k=1;
 for i=1:1:len_w0
    for j=1:1:len_theta
            grid_size=2^(i-1)
            [gabor_even, gabor_odd]=gabor_filter_new(img,K,w0(i),theta(j),p,grid_size);
            
            sze = size(gabor_even,3);
            gabor_even_store(:,:,k:1:k+sze-1)=gabor_even;
            gabor_odd_store(:,:,k:1:k+sze-1)=gabor_odd;
%             figure(1)
%             subplot(len_w0,len_theta,k);
%             imshow(gabor_even,[]);
%             xlabel(theta_deg(j)); ylabel(w0_deg(i));
% 
% 
%             figure(2)
%             subplot(len_w0,len_theta,k);
%             imshow(gabor_odd,[]);
%             xlabel(theta_deg(j)); ylabel(w0_deg(i));
            size(gabor_even)
            size(gabor_odd)
            
%             for l=1:1:size(gabor_even,3)
%                 subplot(grid_size,grid_size,l)
%                 imshow(gabor_even(:,:,l),[])
%             end 

%             for m=1:1:size(gabor_odd,3)
%                 subplot(grid_size,grid_size,m)
%                 imshow(gabor_even(:,:,m),[])
%             end 
%             figure;
            str_title=strcat('angle:',num2str(theta_deg(j)),' freq:', num2str(w0_deg(i)));
     
            for n=1:1:sze
                
            img_filtd_even(:,:,k+n-1)=normalize(conv2(gabor_even(:,:,n),img,'same'));
            img_filtd_odd(:,:,k+n-1)= normalize(conv2(gabor_odd(:,:,n),img,'same'));
            img_filtd_even_coeff(k+n-1)=sum(sum(img_filtd_even(:,:,k+n-1).^2));
            img_filtd_odd_coeff(k+n-1)=sum(sum(img_filtd_odd(:,:,k+n-1).^2));
            img_filtd_coeff(k+n-1)=sqrt(img_filtd_even_coeff(k+n-1) + img_filtd_odd_coeff(k+n-1));
            
            figure;
            subplot(1,2,1)
            imshow(gabor_even(:,:,n),[])
            title(str_title);
            subplot(1,2,2)
            imshow(img_filtd_even(:,:,k+n-1),[])
            title('even filtered img')
            

            figure;
            subplot(1,2,1)
            imshow(gabor_odd(:,:,n),[])
            title(str_title);
            subplot(1,2,2)
            imshow(img_filtd_odd(:,:,k+n-1),[])
            title('odd filtered img')
            
            end
%             for l=1:1:size(gabor_even,3)
%                 subplot(grid_size,grid_size,l)
%                 imshow(gabor_even(:,:,l),[])
%             end 
%             for l=1:1:size(gabor_even,3)
%                 subplot(grid_size,grid_size,l)
%                 imshow(gabor_even(:,:,l),[])
%             end 

% 
%             figure(3);
%             subplot(len_w0,len_theta,k);
%             imshow(img_filtd_even(:,:,k),[]);
%             xlabel(theta_deg(j)); ylabel(w0_deg(i));
% 
% 
%             figure(4);
%             subplot(len_w0,len_theta,k)
%             imshow(img_filtd_odd(:,:,k),[])
%             xlabel(theta_deg(j)); ylabel(w0_deg(i));
% 
% 
%             img_filtd_even_coeff(k+n-1)=sum(sum(img_filtd_even(:,:,k+n-1).^2));
%             img_filtd_odd_coeff(k+n-1)=sum(sum(img_filtd_odd(:,:,k+n-1).^2));
%             img_filtd_coeff(k+n-1)=sqrt(img_filtd_even_coeff(k+n-1) + img_filtd_odd_coeff(k+n-1));
             k=k+sze;
        end 
    end
 
 

 figure;
 plot(0:1:(k-2),img_filtd_coeff,'ro')
 hold on
 plot(0:1:(k-2),img_filtd_coeff,'g')
 xlabel('w0:theta'); ylabel('image contrast energy');grid on;
 title('Image Contrast Energy computed Quadrature pair-wise')

 % contrast energy of filtered image computed quadrature pair-wise for 
 % every orientation and freq.
 
 

