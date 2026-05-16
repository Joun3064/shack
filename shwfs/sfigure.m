function varargout = sfigure(varargin)
if nargin>=1
	if ishandle(varargin{1})
		set(0, 'CurrentFigure', varargin{1});
        h = varargin{1};
	else
		h = builtin('figure', varargin{:});
	end
else
	h = builtin('figure');
end
if nargout
	varargout(1) = {h};
end
