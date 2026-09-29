/* TX_API__send_dband_bcon @ 0x8e0748, 112 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Печатает:
 *   TX_API::send_dband_bcon. length=%d on channel %d.
 *   /home/gatis/sdk/sparrow/fwsrc4/src/fw/inc/tx_api.h
 * Зовут его: add_discovery_bcon, tx_bcon__update_bcon
 * Зовёт сам: __ld_r17_to_r13_ret, __st_r17_to_r13, fw_log__emit2, fw_sysassert_fatal, fwq_tx__enqueue
 */
	.section .text.TX_API__send_dband_bcon,"ax",@progbits
	.global TX_API__send_dband_bcon
TX_API__send_dband_bcon:
	.global L_8e0748
L_8e0748:
	push_s blink
L_8e074a:
	bl L_8c02b8
L_8e074e:
	sub_s sp,sp,0x8
L_8e0750:
	mov_s r13,r0
L_8e0752:
	mov_s r14,r1
L_8e0754:
	mov_s r16,r2
L_8e0756:
	mov_s r17,r3
L_8e0758:
	mov_s r2,0x10151a0
L_8e075e:
	mov_s r0,0x7
L_8e0760:
	mov_s r1,0x2
L_8e0762:
	mov_s r3,r14
L_8e0764:
	bl.d L_8edff8
L_8e0768:
	mov r4,r17
L_8e076c:
	mov_s r15,sp
L_8e076e:
	breq_s r13,0,L_8e07a0
	.global L_8e0770
L_8e0770:
	st_s r13,[r15,0x4]
L_8e0772:
	sub_s r13,r13,0x1c
L_8e0774:
	st_s r13,[r15]
L_8e0776:
	ld_s r1,[sp,0x0]
L_8e0778:
	mov_s r2,0x0
L_8e077a:
	stw_s r14,[r1,0x8]
L_8e077c:
	st r16,[r1, 0x18]
L_8e0780:
	stw_s r2,[r1,0xc]
L_8e0782:
	ld_s r0,[r1,0xc]
L_8e0784:
	stb_s r2,[r1,0x10]
L_8e0786:
	bset_s r0,r0,0x0
L_8e0788:
	st_s r0,[r1,0xc]
L_8e078a:
	stb_s r2,[r1,0xa]
L_8e078c:
	st_s r2,[r1,0x4]
L_8e078e:
	mov_s r0,0x8424a0
L_8e0794:
	bl.d L_8c2460
L_8e0798:
	mov_s r2,r17
L_8e079a:
	b.d L_8c031c
L_8e079e:
	add_s sp,sp,0x8
	.global L_8e07a0
L_8e07a0:
	mov_s r0,blink
L_8e07a2:
	mov_s r2,0x1014d54
L_8e07a8:
	mov_s r1,0x11e9
L_8e07ae:
	bl.d L_8c82c0
L_8e07b2:
	mov_s r3,0xab
L_8e07b4:
	b_s L_8e0770
L_8e07b6:
	nop_s
