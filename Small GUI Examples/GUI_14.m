function [] = GUI_14()
% Demonstrate colored text in a listbox, & how extract user's choice.  
% Creates a listbox which has words of different colors.  When the
% pushbutton is pushed, the users choice is printed to the screen.
% Notice the use of the 'listboxtop' property in the callback.
% This does NOT work in version 6.5.
%
% Author:  Matt Fig
% Date:  7/15/2009

S.fh = figure('units','pixels',...
              'position',[300 300 230 40],...
              'menubar','none',...
              'name','GUI_14',...
              'numbertitle','off',...
              'resize','off');
% We will get different colors by using HTML.   
STR = {'<HTML><FONT COLOR="#66FF66">Green</FONT></HTML>',...
       '<HTML><FONT COLOR="red">Red</FONT></HTML>',...
       '<HTML><FONT COLOR="blue">Blue</FONT></HTML>',...
       '<HTML><FONT COLOR="#FF00FF">Violet</FONT></HTML>',...
       '<HTML><FONT COLOR="black">Black</FONT></HTML>',...
       '<HTML><FONT COLOR="yellow">Yellow</FONT></HTML>'};
S.COL = {'Green','Red','Blue','Violet','Black','Yellow'}; % Lookup table.
S.ls = uicontrol('style','list',...
                 'units','pix',...
                 'position',[10 10 90 25],...
                 'string', STR,...
                 'fontsize',14);
S.pb = uicontrol('style','push',...
                 'units','pix',...
                 'posit',[120 10 100 25],...
                 'string', 'Print Choice',...
                 'fontsize',10,...
                 'callback',{@pb_call,S}); 
             
             
function [] = pb_call(varargin)
% Callback for pushbutton.  Displays user's choice at command line.
S = varargin{3};  % Get structure.
% If the 'value' property was used below, the user's choice might not show
% correctly if the selection was made with the arrows on the listbox.
L = get(S.ls,'listboxtop'); % Get the user's choice.
disp(['Your color choice is:  ' S.COL{L}]) % Print to command line.
