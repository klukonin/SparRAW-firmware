/* ps__sta_has_pending_data @ 0x8ccf0c, 88 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: ka_necessity_detector__task, tx_ppdu_ageing_timeout_detector__task
 * Зовёт сам: __ld_r13_to_r13_ret, hwd_dma__get_881c80, vring__active_ring_table
 */
	.section .text.fw_code,"ax",@progbits
	.p2align 2
	.global ps__sta_has_pending_data
ps__sta_has_pending_data:
	.global L_8ccf0c
L_8ccf0c:
	push_s blink
L_8ccf0e:
	push_s r13
L_8ccf10:
	bl.d L_8cd080
L_8ccf14:
	mov_s r13,r0
L_8ccf16:
	ld_s r1,[r0]
L_8ccf18:
	ld_s r2,[r1,0x24]
L_8ccf1a:
	jl_s.d [r2]
L_8ccf1c:
	mov_s r1,r13
L_8ccf1e:
	cmp r0,0xff
L_8ccf22:
	mov.eq r1,0x0
L_8ccf26:
	beq_s L_8ccf2e
L_8ccf28:
	bl L_8d0894
L_8ccf2c:
	mov_s r1,r0
	.global L_8ccf2e
L_8ccf2e:
	mov_s r2,0x0
L_8ccf30:
	mov_s r0,0x857000
L_8ccf36:
	ld.as r3,[r0,0x71]
L_8ccf3a:
	bset r2,r2,r13
L_8ccf3e:
	ld_s r13,[r0,0x60]
L_8ccf40:
	and_s r3,r3,r2
L_8ccf42:
	ld.as r0,[r0,0x92]
L_8ccf46:
	and_s r13,r13,r2
L_8ccf48:
	and_s r2,r2,r0
L_8ccf4a:
	mov_s r0,0x0
L_8ccf4c:
	cmp_s r1,0x0
L_8ccf4e:
	cmp.eq r3,0x0
L_8ccf52:
	cmp.eq r13,0x0
L_8ccf56:
	cmp.eq r2,0x0
L_8ccf5a:
	beq_s L_8ccf5e
L_8ccf5c:
	mov_s r0,0x1
	.global L_8ccf5e
L_8ccf5e:
	b.d L_8c025c
L_8ccf62:
	extb_s r0,r0
