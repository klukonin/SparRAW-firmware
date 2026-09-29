/* ba_sm__on_rcp_delba_arrived @ 0x8de64c, 36 байт.  Сгенерировано gen_asm_tree.py
 * из дизассемблированной прошивки fw_code.  Заменяется на C/C++
 * по мере декомпиляции; сборка сверяется с оригиналом
 * побайтово, поэтому адрес и размер менять нельзя.
 *
 * Зовёт сам: __ld_r13_ret, basic_sm__inject_event
 */
	.section .text.ba_sm__on_rcp_delba_arrived,"ax",@progbits
	.global ba_sm__on_rcp_delba_arrived
ba_sm__on_rcp_delba_arrived:
L_8de64c:
	push_s blink
L_8de64e:
	push_s r13
L_8de650:
	mov_s r13,r0
L_8de652:
	mov_s r2,r1
L_8de654:
	add_s r0,r0,0x74
L_8de656:
	mov_s r1,0x3
L_8de658:
	mov_s r3,0x0
L_8de65a:
	bl.d L_8d6a1c
L_8de65e:
	mov_s r4,r3
L_8de660:
	ld r0,[r13, 0xac]
L_8de664:
	ld r1,[r0, 0xd4]
L_8de668:
	ld_s r1,[r1,0x8]
L_8de66a:
	jl_s [r1]
L_8de66c:
	b L_8c033c
