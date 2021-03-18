% //This software is licensed under the BSD 3 Clause license: http://opensource.org/licenses/BSD-3-Clause 
% 
% 
% //Copyright (c) 2013, University of Oxford
% //All rights reserved.
% 
% //Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
% 
% //Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
% //Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
% //Neither the name of the University of Oxford nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
% //THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%
%   The method implemented in this file has been patented by their original
%   authors. Commercial use of this code is thus strongly not
%   recocomended.
%
% //Authors: 	Gari D Clifford - 
% //            Roberta Colloca -
% //			Julien Oster	-

function [cosEn,sentropy,mRR,minRR,medFreq] = comp_cosEn(segment)


% comp_cosEn computes cosEn value for the vector 'data'

%Input
%segment: segment of the RR intervals series 

%Output
% cosEn: CosEn value for the vector 'data'
% sentropy: sample entropy
% mRR: mean RR intervals of segment 
% minRR: max heart rate of the segment
% medFreq: median heart rate value of the segment

r=0.03;       %initial value of the tolerance matching
M=2;        %maximum template length

mNc=5;     %minimum numerator count
dr= 0.001;     %tolerance matching increment  %is it ok????????????
A=-1000*ones(M,1);  %number of matches for m=1,...,M

%Compute the number of matches of length M and M-1,
%making sure that A(M) >= mNc
while A(M,1)< mNc
  [e,A,B]=sampen(segment,M,r);
  r=r+dr;
end

if A(M,1)~=-1000
    mRR=mean(segment);
    cosEn= e(M,1)+log(2*(r-dr))-log(mRR);
else
    cosEn=-1000;
end

sentropy=e(M,1);
minRR=min(segment);
medFreq=median(1./segment);

end