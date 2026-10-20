/* tsf__read_scaled @ 0x8ca00c, 44 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, __lshrdi3, fw_read_timer, mac_read_tsf64
 */
	.section .text.tsf__read_scaled,"ax",@progbits
	.global tsf__read_scaled
tsf__read_scaled:
L_8ca00c:
	push_s blink
L_8ca00e:
	push_s r13
L_8ca010:
	sub_s sp,sp,0x10
L_8ca012:
	mov_s r13,r1
L_8ca014:
	mov_s r1,sp
L_8ca016:
	mov_s r0,0x0
L_8ca018:
	bl.d L_8e4840
L_8ca01c:
	mov_s r2,r0
L_8ca01e:
	ld_s r1,[sp,0x4]
L_8ca020:
	ld_s r0,[sp,0x0]
L_8ca022:
	bl.d L_8c0510
L_8ca026:
	mov_s r2,0x4
L_8ca028:
	bl.d L_8e4694
L_8ca02c:
	sub_s r13,r13,r0
L_8ca02e:
	add_s r0,r0,r13
L_8ca030:
	b.d L_8c033c
L_8ca034:
	add_s sp,sp,0x10
L_8ca036:
	nop_s
