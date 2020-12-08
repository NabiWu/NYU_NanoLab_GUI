function [] = plotCycle(expInfo,object,holdOn,ttl,xlbl,ylbl,lg)

coordinateLen = length(object.usableCoordinates);

for i = 1: coordinateLen
    cycleRange = (object.usableCoordinates(i) : (object.usableCoordinates(i)+expInfo.newNumOfPtPerCycle-1));
    plot(expInfo.newData_I(cycleRange),'LineWidth',2)
    if i == coordinateLen
        if holdOn
            hold on
        else
            hold off
        end
    else
        hold on
    end
end

if ~isempty(ttl)
    title(ttl,"Interpreter", "LaTex",'FontSize',19,'FontWeight','bold')
end
if ~isempty(xlbl)
    xlabel(xlbl,"Interpreter", "LaTex",'FontSize',19,'FontWeight','bold')
end
if ~isempty(ylbl)
    ylabel(ylbl,"Interpreter", "LaTex",'FontSize',19,'FontWeight','bold')
end
if ~isempty(lg)
    legend(lg)
end

grid on

end

