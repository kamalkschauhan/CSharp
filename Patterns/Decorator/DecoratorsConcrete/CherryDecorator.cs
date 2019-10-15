namespace DecoratorPattern
{
    class CherryDecorator : Decorator
    {
        public CherryDecorator(BakeryComponent baseComponent)
            : base(baseComponent)
        {
            m_Name = "Cherry";
            m_Price = 2.0;
        }
    }
}
