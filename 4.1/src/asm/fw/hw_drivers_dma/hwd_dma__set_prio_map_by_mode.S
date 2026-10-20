/* hwd_dma__set_prio_map_by_mode @ 0x8cdb40, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   hw_drivers_dma.c
 * Зовут его: hw_modes__apply_power_mode
 * Зовёт сам: __ld_r13_ret, fw_sysassert_fatal
 */
	.section .text.hwd_dma__set_prio_map_by_mode,"ax",@progbits
	.global hwd_dma__set_prio_map_by_mode
hwd_dma__set_prio_map_by_mode:
	.global L_8cdb40
L_8cdb40:
	push_s blink
L_8cdb42:
	push_s r13
L_8cdb44:
	brhs.d r0,0x5,L_8cdb5c
L_8cdb48:
	mov_s r13,r0
L_8cdb4a:
	ldb.x r10,[0x802f30,r13]
L_8cdb52:
	add r0,pcl,0xc
L_8cdb56:
	add1 r0,r0,r10
L_8cdb5a:
	j_s [r0]
	.global L_8cdb5c
L_8cdb5c:
	mov_s r0,blink
L_8cdb5e:
	mov_s r2,0x1018504
L_8cdb64:
	mov_s r1,0x12dc
L_8cdb6a:
	bl.d L_8c82c0
L_8cdb6e:
	mov_s r3,0x1f
L_8cdb70:
	asl_s r1,r13,0x4
L_8cdb72:
	or_s r1,r1,r13
L_8cdb74:
	asl r0,r13,0x8
L_8cdb78:
	or_s r0,r0,r1
L_8cdb7a:
	asl r1,r13,0xc
L_8cdb7e:
	or_s r1,r1,r0
L_8cdb80:
	asl r0,r13,0x10
L_8cdb84:
	or_s r0,r0,r1
L_8cdb86:
	asl r1,r13,0x14
L_8cdb8a:
	or_s r1,r1,r0
L_8cdb8c:
	asl r0,r13,0x18
L_8cdb90:
	or_s r0,r0,r1
L_8cdb92:
	asl_s r13,r13,0x1c
L_8cdb94:
	or_s r0,r0,r13
L_8cdb96:
	mov_s r2,0x880b80
L_8cdb9c:
	st_s r0,[r2,0x68]
L_8cdb9e:
	extb_s r1,r0
L_8cdba0:
	st_s r1,[r2,0x6c]
L_8cdba2:
	bmsk_s r0,r0,0x1b
L_8cdba4:
	mov_s r1,0x880c00
L_8cdbaa:
	st_s r0,[r1,0xc]
L_8cdbac:
	b L_8c033c
