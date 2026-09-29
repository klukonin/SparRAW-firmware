/* vring__reset_pair @ 0x8c8f68, 40 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: vring__set_pair_mode
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_dma__uses_rgf_881c00_8d0b74, hwd_dma__uses_rgf_881c00_8d0c18, rm_main_sm__check_field_2c
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global vring__reset_pair
vring__reset_pair:
	.global L_8c8f68
L_8c8f68:
	push_s blink
L_8c8f6a:
	push_s r13
L_8c8f6c:
	mov_s r13,r0
L_8c8f6e:
	mov r0,-0x1
L_8c8f72:
	bl.d L_8d0c18
L_8c8f76:
	mov_s r1,0x1
L_8c8f78:
	mov r0,-0x1
L_8c8f7c:
	bl.d L_8d0b74
L_8c8f80:
	mov_s r1,0x1
L_8c8f82:
	bl.d L_8c5b08
L_8c8f86:
	add r0,r13,0x28
L_8c8f8a:
	b L_8c025c
L_8c8f8e:
	nop_s
