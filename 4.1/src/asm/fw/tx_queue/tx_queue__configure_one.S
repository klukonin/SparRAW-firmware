/* tx_queue__configure_one @ 0x8e5020, 108 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   tx_queue.c
 * Зовут его: mac_bringup__init_tx_queues
 * Зовёт сам: __ld_r16_to_r13_ret, __st_r16_to_r13, fw_sysassert_fatal
 */
	.section .text.tx_queue__configure_one,"ax",@progbits
	.global tx_queue__configure_one
tx_queue__configure_one:
	.global L_8e5020
L_8e5020:
	push_s blink
L_8e5022:
	bl L_8c02bc
L_8e5026:
	mov_s r16,r0
L_8e5028:
	mov_s r0,0x1c1ddf
L_8e502e:
	mov_s r13,r1
L_8e5030:
	mov_s r14,r2
L_8e5032:
	bbit0 r0,r1,L_8e5074
	.global L_8e5036
L_8e5036:
	asl r4,r16,0x5
L_8e503a:
	add r4,r4,0x4435800
L_8e5042:
	lsr r4,r4,0x3
L_8e5046:
	bic r0,r4,0x3
L_8e504a:
	st_s r13,[r0]
L_8e504c:
	breq_s r14,0,L_8e5070
L_8e504e:
	mov_s r1,0x886c00
L_8e5054:
	ld_s r0,[r1,0x74]
L_8e5056:
	bic r0,r0,0xff
L_8e505a:
	or r0,r0,0x30
L_8e505e:
	st_s r0,[r1,0x74]
L_8e5060:
	ld_s r0,[r1,0x70]
L_8e5062:
	and r0,r0,0xffff0000
L_8e506a:
	or r0,r0,0x14
L_8e506e:
	st_s r0,[r1,0x70]
	.global L_8e5070
L_8e5070:
	b L_8c0324
	.global L_8e5074
L_8e5074:
	mov_s r0,blink
L_8e5076:
	mov_s r2,0x10100b0
L_8e507c:
	mov_s r1,0x23
L_8e507e:
	bset_s r1,r1,0xc
L_8e5080:
	bl.d L_8c82c0
L_8e5084:
	mov r3,0x298
L_8e5088:
	b_s L_8e5036
L_8e508a:
	nop_s
