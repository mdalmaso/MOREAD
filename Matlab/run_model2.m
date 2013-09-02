cvap = [1];
qvap = 1;
sinksfiles = {'SINKDIST_0.TXT' 'SINKDIST_01.TXT' 'SINKDIST_10.TXT'}
sinksfiles = {'SINKDIST_0.TXT'};

for s= 1:length(sinksfiles),
    delete('SINKDIST.TXT')
    
    str = sprintf('!cp %s SINKDIST.TXT',char(sinksfiles{s}))
    eval(str)
    runns = [64+s '_'];
    
    for i = 1:length(cvap),
        
        
        
        run_name = sprintf('%sQVAP_test%02i',runns,i)
        
        in.imax = 1000;
        in.temp = 273.15;
        in.rh = 0.75;
        in.pres = 1.0;
        in.nucsize = 8;
        in.nucrate = 1000.*1e6;
        in.pulse_length = 60;
        in.cond_on = 1;
        in.evap_on = 0;
        in.sink_on = 0;
        in.coag_on = 0;
        in.nuc_mech = 1;
        in.nuc_coeff = 1e-14;
        in.nuc_exp = 3;
        in.nuc_coeff_org = 1e-14;
        in.nuc_exp_org = 2;
        in.cvap_0 = cvap(i).*1e7.*1e6;
        in.qvap_0 = qvap(i).*1e5.*1e6;
        
        make_model_setup(in)
        
        delete('DISC_TEST.TXT')
        delete('DISC_DIAMETERS.TXT')
try        
        !./test.bin
        
        a = load('DISC_TEST.TXT');
        b = load('DISC_DIAMETERS.TXT');
        
        out.time  = a(:,1);
        out.concs = a(:,2:end); % note: all under nucsize is rubbish
        out.drydiam = b(1,:);
        out.wetdiam = b(2,:);
        
        sav = sprintf('DR_%s.mat',run_name);
        save(sav,'in','out')
catch
    fprintf('Run %s failed!',run_name)
end
    
    end
end

 plot_disc_auto(in,out)