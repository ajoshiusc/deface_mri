function vol2png(vol,pngbase,SZX,SZZ)

M=size(vol);

vol=vol/max(vol(:));

svol=sum(sum(vol,1),3);
fst=min(find(svol>0));lst=max(find(svol>0));

ln=linspace(fst,lst,10);ln=round(ln);
jj1=1;
for jj=ln(2:end-1)
    
    h=figure('Visible','off');
    im1=imrotate(squeeze(vol(:,jj,:)),90);
    imagesc(imresize(im1,round([size(im1,1)/SZX,size(im1,2)/SZZ])));axis off;
    colormap gray;%set(gca,'position',[0 0 1 1],'units','normalized');
    
    saveas(h,sprintf('%s_%d.png',pngbase,jj1));
    autocrop_img(sprintf('%s_%d.png',pngbase,jj1));
    jj1=jj1+1;
end
