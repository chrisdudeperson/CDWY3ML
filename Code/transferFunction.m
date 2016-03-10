function tf=transferFunction(input,output)
    
    inputFFT = fft(input);
    outputFFT = fft(output);

    for i = 1:length(inputFFT)
        if real(inputFFT(i))==0       
            inputFFT(i)=complex(0.00001,imag(inputFFT(i)));
        end
        if imag(inputFFT(i))==0
            inputFFT(i)=complex(real(inputFFT(i)),0.00001);
        end
    end
    for i = 1:length(outputFFT)
        if real(outputFFT(i))==0       
            outputFFT(i)=complex(0.00001,imag(outputFFT(i)));
        end
        if imag(outputFFT(i))==0
            outputFFT(i)=complex(real(outputFFT(i)),0.00001);
        end
    end
    
    tf = outputFFT./inputFFT;
    
    
end
