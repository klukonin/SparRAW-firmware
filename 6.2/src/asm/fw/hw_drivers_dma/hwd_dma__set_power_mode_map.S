/* hwd_dma__set_power_mode_map @ 0x8d0908, 104 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: hw_modes__apply_power_mode
 * Зовёт сам: __ld_r13_to_r13_ret, fw_sysassert_fatal
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global hwd_dma__set_power_mode_map
hwd_dma__set_power_mode_map:
	.global L_8d0908
L_8d0908:
	push_s blink
L_8d090a:
	push_s r13
L_8d090c:
	brhs.d r0,0x5,L_8d0924
L_8d0910:
	mov_s r13,r0
L_8d0912:
	ldb.x r10,[0x803830,r13]
L_8d091a:
	add r0,pcl,0xc
L_8d091e:
	add1 r0,r0,r10
L_8d0922:
	j_s [r0]
	.global L_8d0924
L_8d0924:
	mov_s r0,blink
L_8d0926:
	mov_s r1,0x12dc
L_8d092c:
	bl L_8c9b28
L_8d0930:
	asl_s r1,r13,0x4
L_8d0932:
	or_s r1,r1,r13
L_8d0934:
	asl r0,r13,0x8
L_8d0938:
	or_s r0,r0,r1
L_8d093a:
	asl r1,r13,0xc
L_8d093e:
	or_s r1,r1,r0
L_8d0940:
	asl r0,r13,0x10
L_8d0944:
	or_s r0,r0,r1
L_8d0946:
	asl r1,r13,0x14
L_8d094a:
	or_s r1,r1,r0
L_8d094c:
	asl r0,r13,0x18
L_8d0950:
	or_s r0,r0,r1
L_8d0952:
	asl_s r13,r13,0x1c
L_8d0954:
	or_s r0,r0,r13
L_8d0956:
	mov_s r2,0x880b80
L_8d095c:
	st_s r0,[r2,0x68]
L_8d095e:
	extb_s r1,r0
L_8d0960:
	st_s r1,[r2,0x6c]
L_8d0962:
	bmsk_s r0,r0,0x1b
L_8d0964:
	mov_s r1,0x880c00
L_8d096a:
	st_s r0,[r1,0xc]
L_8d096c:
	b L_8c025c
