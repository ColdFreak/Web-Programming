defmodule Geom do
	@doc """
	Calculates the area of a rectangle, given the length and width.
	Returns the product of its arguments. The default value for
    both arguments is 1.
	"""
	@spec area({ atom(), number(), number()} ) :: number()

	def area({shape, dim1, dim2}) do
		area(shape, dim1, dim2)
	end

	@spec area( atom(), number(), number() ) :: number()
	defp area( shape, length, heigh ) when length >= 0 and heigh >= 0 do
		case shape do
			:rectangle ->
				length*heigh
			:triangle ->
				length*heigh/2.0
			:ellipse ->
				:math.pi()*length*heigh
		end
	end
end
