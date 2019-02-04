## Object Oriented Programming

The basic idea of encapsulation is that you are going to protect your data
structure (struct) by using methods (functions) to get and/or set the
properties instead of making them directly readable/writable.

For example:

    struct Weapon
    {
        protected int damage;
        import int GetDamage();
        import void SetDamage(int);
    };

    int Weapon::GetDamage()
    {
        return this.damage;
    }

    void Weapon::SetDamage(int damage)
    {
        this.damage = damage;
    }

Why would you want to do this you ask? Let's say for example that you want to
make sure that the damage property of your Weapons is always a positive (or 0)
value. If the user could directly set `sword.damage = -15;` then you would have
no way to prevent the property being changed. To further extrapolate this
problem if the user of this code is defining dynamic instances of this struct
you wouldn't even be able to authenticate the data using repeatedly_execute
(short of forcing them to call an Update method every loop).

By encapsulating the property you can make sure that the user is supplying a
valid value before storing it into the instance:

    void Weapon::SetDamage(int damage)
    {
        if (damage < 0) damage = 0;
        this.damage = damage;
    }

Now if the user supplies an invalid value for the damage it will be replaced
with 0. This makes sure that the damage does not get set to a negative value.

### Protection

Access modifiers can be applied to struct members to set the access and
modifiction scope of struct members.

| Keyword | Get | Set |
| --- | --- | --- |
| `readonly` | Yes | No |
| `writeprotected` | Yes | Using `this` |
| `protected` | Using `this`| Using `this` |

### Defing attributes

**Note:** You cannot use an attribute in the same script where the getter
and setter methods are defined. If you try, you'll get an error like this:

    Error: is_script_import: NULL pointer passed

The keyword attribute is actually comparable to the C# idea of properties,
though the actual implementation is of course different. An attribute gives us
the ability to encapsulate our properties so we can protect our data without
losing the ease of access that just using properties grants.

An attribute is declared more like a method than a property. You must also
supply two functions for each attribute, a getter and a setter, named get_XXX
and set_XXX respectively where XXX is the name of the attribute. The named
attributes themselves are considered virtual, so there also needs to be a
struct member used to store the data.

For example:

    struct Weapon
    {
        protected int damage; // this is our actual property to store the damage
        import attribute int Damage; // this is our attribute
        import int get_Damage();
        import void set_Damage(int damage);
    };

    int Weapon::get_Damage()
    {
        return this.damage;
    }

    void Weapon::set_Damage(int damage)
    {
        this.damage = damage;
    }

It is also possible to use the attribute keyword to encapsulate array access,
this time by using a getter named geti_XXX and and setter named seti_XXX. Since
dynamic arrays are not supported as struct members you would typically have to
declare the actual property with a static size.

For example:

    #define MAX_PEOPLE_COUNT 20 // max 20 people
 
    struct People
    {
        protected String names[MAX_PEOPLE_COUNT];
        import attribute String Names[];
        import String geti_Names(int index);
        import void seti_Names(int index, String name);
        readonly import attribute int Count;
        import int get_Count();
    };

    String People::geti_Names(int index)
    {
        if ((index < 0) || (index >= MAX_PEOPLE_COUNT)) return null; // invalid index
        return this.names[index];
    }

    void People::seti_Names(int index, String name)
    {
        if ((index < 0) || (index >= MAX_PEOPLE_COUNT)) return;
        if (String.IsNullOrEmpty(name)) name = "John Doe";
        this.names[index] = name;
    }

    int People::get_Count()
    {
        return PEOPLE_COUNT;
    }

### Access with extender functions

By default getter and setter methods will show in autocomplete data within the
script editor, unless explicity disabled per definition:

    struct Weapon
    {
        protected int damage;
        import attribute int Damage;
        import int get_Damage(); // $AUTOCOMPLETEIGNORE$
        import void set_Damage(int damage); // $AUTOCOMPLETEIGNORE$
    };

This hides them within the script editor but it still means that the functions
are globally accessible and we have to reference them in the script header. By
using [extender functions](ExtenderFunctions) instead, we no longer need to
define them in the script header and no longer need to add the special tokens
to have the functions ignored for autocomplete purposes.

Example script header:

    // Script.ash

    struct Weapon
    {
        protected int damage;
        import attribute int Damage;
    };

Example script:

    // Script.asc

    int get_Damage(this Weapon*)
    {
        return this.damage;
    }

    void set_Damage(this Weapon*, int damage)
    {
        if (damage < 0) damage = 0;
        this.damage = damage;
    }

### Static attributes

Using an attribute will actually allow you to simulate define static properties
within a struct.

    struct Some
    {
        import static attribute int Thing;
    };

    // since the attribute is static, adding a property to the struct doesn't make sense
    int Some_Thing;

    // even though it's static we can still use extenders to define the accessors
    int get_Thing(this Some*) 
    {
        return Some_Thing;
    }

    void set_Thing(this Some*, int thing)
    {
        Some_Thing = thing;
    }
    
    // Meanwhile, in some other script...
    Some.Thing = 42;
