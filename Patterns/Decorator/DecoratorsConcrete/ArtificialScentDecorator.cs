namespace DecoratorPattern
{
    class ArtificialScentDecorator : Decorator
    {
        public ArtificialScentDecorator(BakeryComponent baseComponent)
            : base(baseComponent)
        {
            m_Name = "Artificial Scent";
            m_Price = 3.0;
        }
    }
}
