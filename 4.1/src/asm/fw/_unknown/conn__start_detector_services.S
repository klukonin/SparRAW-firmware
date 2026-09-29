/* conn__start_detector_services @ 0x8de764, 48 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовут его: conn_mgr__awake_peer_ntf
 * Зовёт сам: __ld_r14_to_r13_ret, __st_r14_to_r13, ageing_detector__start_service, ka_detector__start_service
 */
	.section .text.conn__start_detector_services,"ax",@progbits
	.global conn__start_detector_services
conn__start_detector_services:
	.global L_8de764
L_8de764:
	b.d L_8de76c
L_8de768:
	add_s r0,r0,0x64
L_8de76a:
	nop_s
	.global L_8de76c
L_8de76c:
	push_s blink
L_8de76e:
	bl L_8c02c4
L_8de772:
	mov_s r13,r0
L_8de774:
	ld_s r0,[r0,0x48]
L_8de776:
	mov_s r14,r1
L_8de778:
	cmp_s r0,0x0
L_8de77a:
	bl.ne L_8de800
L_8de77e:
	ld_s r0,[r13,0x48]
L_8de780:
	cmp_s r0,0x0
L_8de782:
	add2.ne r0,r0,0x15
L_8de786:
	bl.ne.d L_8de7dc
L_8de78a:
	mov.ne r1,r14
L_8de78e:
	b L_8c0334
L_8de792:
	nop_s
