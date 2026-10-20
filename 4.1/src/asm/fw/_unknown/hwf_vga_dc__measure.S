/* hwf_vga_dc__measure @ 0x8d3d74, 76 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hwf_vga_dc__calibrate
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, hwd_phy__read_status_pair, hwd_phy__rgf_883000_8cf74c
 */
	.section .text.hwf_vga_dc__measure,"ax",@progbits
	.global hwf_vga_dc__measure
hwf_vga_dc__measure:
	.global L_8d3d74
L_8d3d74:
	push_s blink
L_8d3d76:
	bl.d L_8c02c4
L_8d3d7a:
	mov_s r2,0x0
L_8d3d7c:
	sub_s sp,sp,0x8
L_8d3d7e:
	mov_s r14,r0
L_8d3d80:
	mov_s r13,r1
L_8d3d82:
	mov_s r0,0x0
L_8d3d84:
	bset r0,r0,r1
L_8d3d88:
	bl.d L_8cf74c
L_8d3d8c:
	mov_s r1,0x1
L_8d3d8e:
	bl.d L_8cf6f8
L_8d3d92:
	mov_s r0,sp
L_8d3d94:
	breq_s r14,0,L_8d3d9a
L_8d3d96:
	ld_s r1,[sp,0x4]
L_8d3d98:
	b_s L_8d3d9c
	.global L_8d3d9a
L_8d3d9a:
	ld_s r1,[sp,0x0]
	.global L_8d3d9c
L_8d3d9c:
	sub_s r2,r13,0x1
L_8d3d9e:
	mov_s r0,0x0
L_8d3da0:
	bset r0,r0,r2
L_8d3da4:
	cmp_s r1,0x0
L_8d3da6:
	add.ge r0,r0,r1
L_8d3daa:
	asr.ge r0,r0,r13
L_8d3dae:
	bge_s L_8d3db6
L_8d3db0:
	sub_s r0,r0,r1
L_8d3db2:
	asr_s r0,r0,r13
L_8d3db4:
	neg_s r0,r0
	.global L_8d3db6
L_8d3db6:
	sexb_s r0,r0
L_8d3db8:
	b.d L_8c0334
L_8d3dbc:
	add_s sp,sp,0x8
L_8d3dbe:
	nop_s
