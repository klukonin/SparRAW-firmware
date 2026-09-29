/* mac_bringup__init_rx_desc @ 0x8efe10, 64 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: l2mgr__mac_bringup
 * Зовёт сам: __ld_r13_ret, memset0_words, rx_desc__fill_defaults
 */
	.section .text.mac_bringup__init_rx_desc,"ax",@progbits
	.global mac_bringup__init_rx_desc
mac_bringup__init_rx_desc:
	.global L_8efe10
L_8efe10:
	push_s blink
L_8efe12:
	push_s r13
L_8efe14:
	sub_s sp,sp,0x58
L_8efe16:
	mov_s r0,sp
L_8efe18:
	bl.d L_8c1a78
L_8efe1c:
	mov_s r1,0x58
L_8efe1e:
	mov_s r13,sp
L_8efe20:
	mov_s r0,r13
L_8efe22:
	bl.d L_8df994
L_8efe26:
	mov_s r1,0x1f
L_8efe28:
	mov_s r0,r13
L_8efe2a:
	bl.d L_8df994
L_8efe2e:
	mov_s r1,0x0
L_8efe30:
	mov_s r0,r13
L_8efe32:
	bl.d L_8df994
L_8efe36:
	mov_s r1,0x1
L_8efe38:
	mov_s r0,r13
L_8efe3a:
	bl.d L_8df994
L_8efe3e:
	mov_s r1,0x2
L_8efe40:
	mov_s r0,r13
L_8efe42:
	bl.d L_8df994
L_8efe46:
	mov_s r1,0x3
L_8efe48:
	b.d L_8c033c
L_8efe4c:
	add_s sp,sp,0x58
L_8efe4e:
	nop_s
