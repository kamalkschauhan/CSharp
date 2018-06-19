using System;
using System.Collections.Generic;
using System.Linq.Expressions;
using System.Text;

namespace CSharp.RepositoryPattern
{
    public abstract class EntityBase
    {
        public int Id { get; protected set; }
    }

    public class Customer : EntityBase
    {
        public string CustomerName { get; set; }
        public int CustomerAge { get; set; }
    }
    public class Product : EntityBase
    {
        public string ProductName { get; set; }
        public string Category { get; set; }
    }

    public interface IRepository<T> where T : EntityBase
    {
        void Add(T entity);
        void Update(T entity);
        void Delete(T entity);
        T GetById(int id);
        IEnumerable<T> GetAll();
    }

    public class Repository<T> : IRepository<T> where T : EntityBase
    {
        public void Add(T entity)
        {
            throw new NotImplementedException();
        }

        public void Update(T entity)
        {
            throw new NotImplementedException();
        }

        public void Delete(T entity)
        {
            throw new NotImplementedException();
        }

        public T GetById(int id)
        { 
            throw new NotImplementedException();
        }
        public IEnumerable<T> GetAll()
        {
            throw new NotImplementedException();
        }
    }
    public class CustomerRepository : IRepository<Customer>
    {
        public void Add(Customer entity)
        {
            throw new NotImplementedException();
        }

        public void Update(Customer entity)
        {
            throw new NotImplementedException();
        }

        public void Delete(Customer entity)
        {
            throw new NotImplementedException();
        }

        public Customer GetById(int id)
        {
            throw new NotImplementedException();
        }
        public IEnumerable<Customer> GetAll()
        {
            throw new NotImplementedException();
        }
    }
    public class ProductRepository : IRepository<Product>
    {
        public void Add(Product entity)
        {
            throw new NotImplementedException();
        }

        public void Update(Product entity)
        {
            throw new NotImplementedException();
        }

        public void Delete(Product entity)
        {
            throw new NotImplementedException();
        }

        public Product GetById(int id)
        {
            throw new NotImplementedException();
        }
        public IEnumerable<Product> GetAll()
        {
            throw new NotImplementedException();
        }

    }
}
