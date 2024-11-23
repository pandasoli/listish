# Listish 🐊
> This is a simple but highly customizable library to
> add selection lists to your BatchScript programs

<br>

```cmd
set names="Eli Soli" GitHub Jean "Kamilly Evelin"
call listish "up_ch=wk down_ch=sj sel_cl=1 unsel_cl=90", names, answer

echo Selected item's index: %errorlevel%
echo Selected item: %out%
```

## Usage

As you could see in the example above you have to `call` it.  
And doing so as first parameters it expects some attributes:

- `width`: Width of the list
- `height`: Height of the list
- `pos_y`: Vertical position of the list
- `pos_x`: Horizontal position of the list
- `up_ch`: Sequence of characters used to move up
- `down_ch`: Sequence of characters used to move down
- `sel_ch`: Sequence of characters used to select an item
- `sel_cl`: ANSI color of selected item
- `sel_align`: Text alignment of selected item (left, center, right)
- `sel_left`: Text to show on the left of selected item
- `sel_right`: Text to show on the right of selected item
- `unsel_cl`: ANSI color of unselected item
- `unsel_align`: Text alignment of selected item (left, center, right)
- `unsel_left`: Text to show on the left of unselected item
- `unsel_right`: Text to show on the right of unselected item
- `sel`: Initial selected item
- `scroll`: Initial scroll position

<div align=center>
  
A look example:  
![img](https://github.com/user-attachments/assets/2d4310f2-da71-48f3-883a-c977a3ec0063)
</div>
