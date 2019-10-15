namespace DecoratorPattern
{
    class CreamDecorator : Decorator
    {
        public CreamDecorator(BakeryComponent baseComponent)
            : base(baseComponent)
        {
            m_Name = "Cream";
            m_Price = 1.0;
        }
    }
}
