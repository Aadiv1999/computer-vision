function [hLinked] = getConnectedEdges(hLinked, row, col)


[r,c] = size(hLinked);
 % check for edge condition
    for i=-1:1 % iterate through 8 neighbours
        for j=-1:1
            
                
            if( (row+i>1 && row+i<r) && (col+j>1 && col+j<c) )
                if( (hLinked(row+i,col+j) > 0) && (hLinked(row+i,col+j) < 255) )
                    hLinked(row,col) = 255;
                    hLinked = getConnectedEdges(hLinked, row+i, col+j);                
                end
            end

            
        end
    end
    
    
end
