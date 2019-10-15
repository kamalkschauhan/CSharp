namespace DecoratorPattern
{
    class ArtificialScentDecorator : Decorator
    {
        public ArtificialScentDecorator(BakeryComponent baseComponent)
            : base(baseComponent)
        {
            this.m_Name = "Artificial Scent";
            this.m_Price = 3.0;
        }
    }
}
