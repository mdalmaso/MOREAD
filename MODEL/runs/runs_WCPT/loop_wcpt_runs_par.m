% run some runs
% documentation
% first runs: outgrown particles dont add to sink
% second set: outgrown particles add to sink: denoted by _bl_
% third set: outgrown particles add to sink + background sink is scaled by
% vapor concentration (very approximatively)







sinks = [1e-6 5e-1 1e-1 1.0];
Cvap  = [ 1e12 5e12 1e13 5e13 1e14].*1e6;

for s = 1:length(sinks),
    parfor c = 1:length(Cvap),
        
            run_name = sprintf('wcpt_CS0%i_bigCvap%i_rs2_act',s,c);
            
            run_MOREAD('imax',1000,'const_cvap',0,'cvap_0',Cvap(c),'condsink_value',sinks(s),'nuc_mech',1,'nuc_coeff',5e-4,'runfilename',run_name,'nucsize',12)
      
            
            run_name = sprintf('wcpt_CS0%i_bigCvap%i_rs2_actLO',s,c);
            
            run_MOREAD('imax',1000,'const_cvap',0,'cvap_0',Cvap(c),'condsink_value',sinks(s),'nuc_mech',1,'nuc_coeff',1e-4,'runfilename',run_name,'nucsize',12)
       
            run_name = sprintf('wcpt_CS0%i_bigCvap%i_rs2_actHI',s,c);
            
            run_MOREAD('imax',1000,'const_cvap',0,'cvap_0',Cvap(c),'condsink_value',sinks(s),'nuc_mech',1,'nuc_coeff',1e-3,'runfilename',run_name,'nucsize',12)
            
    end
end




% return
% clear all
% 
% sinks = [1e-4 1e-1 5e-1];
% Cvap  = [1e9 1e10 1e11 ].*1e6;
% 
% 
% for s = 1:length(sinks),
%     for c = 1:length(Cvap),
%         
%             run_name = sprintf('wcpt_CS0%i_Cvap%i_realsink_kin',s,c);
%             
%             run_MOREAD('imax',1000,'const_cvap',0,'cvap_0',Cvap(c),'condsink_value',sinks(s),'nuc_mech',2,'nuc_coeff',1e-21,'runfilename',run_name,'nucsize',12)
%       
%     end
% end
